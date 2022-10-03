Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72CB5F3320
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJCQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJCQNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:13:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A648331EF4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:13:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so6119083wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7dQXLQGjmAcl/xcPVLsk1EjIAQGW9LYFw0dKgGXUj4M=;
        b=b2R3jRKx+U+3OqygRYsWqU7FHxxsZAJlQ90cBgHYqLYttQM/MNQJGP5ihX+D/zm1jY
         XCwzZvpjXgUSIu3ISJxgnr0GgPSG7UbWUWoAu927D0izLhr99o0ALAsojigTA5eyhKJK
         ml9/oje5dYmEz9CZDvHlG+wMvU3DsDiqpXOVk0yexebGy/HpcknMfg+Rr9Q9Tpmyar+Q
         vjrD5YdoBHvFZr81/ssVsx478RM3vxc/KQAoFvlRIqYlOhwBcx2IuYGh7poYcFt3/xFL
         rdoTgrS44peaBZ2yy0qJH373+kvn1JPJjv3apL/e38xqjE7xlHHLCdelz89Y6lR2noV/
         GPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7dQXLQGjmAcl/xcPVLsk1EjIAQGW9LYFw0dKgGXUj4M=;
        b=U9l60dVfmRnTj56b9R5uPWyCSdM5Bh3e/3dyRIHS1GW+KuwCpgkYm5HkkDnleUT2JX
         6Zq/t+n3nD9lJ0lE/0NSvdIYCvNizaBncag/w6LM2LccyFQ83ogHVHfyzmTJDn5YpFAZ
         IMNrmav5jDMf+ntsROAnxYymhnKJjA8fNXg4ZcGHtOOnnMlBcJ806xsy0zlHFtWeKxaL
         fsJan5ksJRJS3W+bijuhWCcy5l4v4/WEeVoRIiqIeWOJEEuVd6wcYbI+PjwxCCpNvOLm
         qNAypT/9E3GkNzkaPqAqsXxeD+cor1zfeC5pZpK6U/IQ/sJHLqRjh2nxiegPmH1LeGZe
         UQJA==
X-Gm-Message-State: ACrzQf2Xzb2pDerEKf9YSit0Kyx18FRgHNe3d9BHFkE7mEEBvLLR0np+
        lek93oo9Jq6rLoFdgsOYVVed/Q==
X-Google-Smtp-Source: AMsMyM47DVIIhlKgvmYj/r0Y7oHp7KVO/2q6/YOFDYvztqyixbC3rZnvTR+boBsjLDsifmwqGUVA5w==
X-Received: by 2002:a05:600c:1d8f:b0:3b4:90c1:e23a with SMTP id p15-20020a05600c1d8f00b003b490c1e23amr7381633wms.122.1664813613265;
        Mon, 03 Oct 2022 09:13:33 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v129-20020a1cac87000000b003a845621c5bsm12111335wme.34.2022.10.03.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:13:32 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v4 1/2] get_maintainer: Print maintainer for S: Supported
Date:   Mon,  3 Oct 2022 17:13:28 +0100
Message-Id: <20221003161329.431107-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003161329.431107-1-bryan.odonoghue@linaro.org>
References: <20221003161329.431107-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Throughout the documentation we make reference to maintainers as the people
who ought to be mailed when sending patches.

Right now get_maintainer.pl returns "supporter" for maintained files which
are denoted "S: Supported".

Update get_maintainer to output "maintainer" for "S: Supported" the
differentiation between paid (v) non-paid maintainers doesn't impact who
needs to be mailed for patch submissions.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9b..7a8d2961d948d 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1283,7 +1283,7 @@ sub get_maintainer_role {
 
     $role = lc($role);
     if      ($role eq "supported") {
-	$role = "supporter";
+	$role = "maintainer";
     } elsif ($role eq "maintained") {
 	$role = "maintainer";
     } elsif ($role eq "odd fixes") {
-- 
2.37.3

