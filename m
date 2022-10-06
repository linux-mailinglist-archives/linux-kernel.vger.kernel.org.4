Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F405F6B89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJFQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJFQYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:24:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4EEC14BA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:24:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w18so3497849wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1737BWbHSLds7LDmn1FtXOdzo9+FGaitkwJX/gaoOs=;
        b=lsnseBf/mneyrl6sXQYoF8foMkrV4r2y6kVfBdZXC4stoDIWHomoM8se7TtKBI2cw0
         2aiev64niQM7EgkTqqSfTzKk2B8V6wXKPjm5rxCMxkF8b286rHPezFKXh6MPcZmaziMG
         ochTy2uvZTMEPb7NZoFxxnOHC8jzPNhxeWqrdjEDh2Y6wUu+a+P8GpVWsfBnzDINp33T
         wK4clPp74zGyvTMeROLOj5FjjkGoTcMU9KcqZGJEW1UepT6YuGX6JRjqa1QBmR1ZLF/u
         PGxk14870jeXw1+9b8hyzD4h+z8ImaRBpCXpIE8MgKLaoLLuMRvJIv4QLaRLfeHLGDgS
         nJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1737BWbHSLds7LDmn1FtXOdzo9+FGaitkwJX/gaoOs=;
        b=73h9hKf+5GMCmGhH18xd9fDga67b8fM435Py8CdXqL7ZxLLxHRt9R7QYTPDdal5Y2C
         B5ufLOSHEffPJIuXPag6yfO/iHWp4o3PAJAMxs7dF1buetVUZgLeA3my2IA0jAbGoze9
         cUXM0PjukXPAoIQHBnyDF9l8TqHkhTmwlDiKeYfrao/rtpQdXwNIvJWZ/gaUqFWcp6e/
         U40UqgOQEWER1op0CjshyX+1GiaMrUmzkwBf+lXr0qAGEX1+VDLo4eT24b7X6gxEkpD2
         XrA7Ikv2u7SkTtdcNAFf3ffX9SrLWgjRfqH8oP39d6vlGFOoxp8O+zSiBQi0zRq1nQ2/
         6GmA==
X-Gm-Message-State: ACrzQf0eRFYiLFE852q3igc+QV87OKYbyEoh1m/phLrGH6wc38VnnnrE
        o8ifwhJK6+ZW7I3Y/sNCeg9nkfpCNur+Iw==
X-Google-Smtp-Source: AMsMyM5y/tT99msvM6m6YBtqBy0+vdBUS3hM6NvDqRfv7JLwBY1H1hEfCoPFRtI3aEB6ZzsUXJsTTA==
X-Received: by 2002:a05:6000:154a:b0:22a:b8eb:ba53 with SMTP id 10-20020a056000154a00b0022ab8ebba53mr531061wry.594.1665073456839;
        Thu, 06 Oct 2022 09:24:16 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c1c9300b003c1b492daa4sm3180145wms.36.2022.10.06.09.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:24:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6] Documentation/process: Be more explicit about who to mail on patch submission
Date:   Thu,  6 Oct 2022 17:24:13 +0100
Message-Id: <20221006162413.858527-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006162413.858527-1-bryan.odonoghue@linaro.org>
References: <20221006162413.858527-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently when submitting a yaml change I found that I had omitted the
maintainer whose tree the change needed to go through.

The reason for that is the path in MAINTAINERS is marked as Supported not
Maintained. Reading MAINTAINERS we see quote:

           Supported:   Someone is actually paid to look after this.
           Maintained:  Someone actually looks after it.

The current submitting-patches.rst only says to mail maintainers though not
supporters. Discussing further on the list the suggestion was made to state
that the following are the right addresses to mail:

- Maintainers
- Supporters
- Reviewers
- Mailing lists

Add in a sentence to capture that statement.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/process/submitting-patches.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be49d8f2601b4..a56e10811e8de 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -227,9 +227,11 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
 to code that they maintain; look through the MAINTAINERS file and the
 source code revision history to see who those maintainers are.  The
 script scripts/get_maintainer.pl can be very useful at this step (pass paths to
-your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
-maintainer for the subsystem you are working on, Andrew Morton
-(akpm@linux-foundation.org) serves as a maintainer of last resort.
+your patches as arguments to scripts/get_maintainer.pl).  If you are using
+scripts/get_maintainer.pl it is a good idea to mail every maintainer, supporter,
+reviewer and mailing list given. If you cannot find a maintainer for the
+subsystem you are working on, Andrew Morton (akpm@linux-foundation.org) serves
+as a maintainer of last resort.
 
 You should also normally choose at least one mailing list to receive a copy
 of your patch set.  linux-kernel@vger.kernel.org should be used by default
-- 
2.37.3

