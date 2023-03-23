Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7774C6C6B65
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCWOpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCWOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:45:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C128523A79;
        Thu, 23 Mar 2023 07:45:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so87753494edo.2;
        Thu, 23 Mar 2023 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679582709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkZtZRWwDV6yq9X5+ka1CKddoIkNJT/5gBkOd73Dzhk=;
        b=fWbdg8d08k+UL2B3EdfqQaYnk+sH8AlzOL0Ttg/V8/ZeI+g5mp2Z0sAF9FbObBSTtF
         U79d5sx/p22jFcT1c7JVwd1EKNNNfXUYUlM4Lr5DArSsbhciyU9fDXPSR3RXj2OoOj/x
         wnANmmzmwam86O2UKvevVImuC4HMGit4j55hMoDljuvhQtJYwkPz66DGY14jGVfM167U
         CZxapPbwqDjeko6BhDTXeiDPy+uN7naF99XskRQYxr+hSJDdXbMQ3y5S7Uw1scdfvsff
         cXISSCqSfJ02ZCZnPAAjuR8lvY0DB7oxW/+Q7IiC9rZWISNsnRtMCaCEgVkh19bE0NOF
         UKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkZtZRWwDV6yq9X5+ka1CKddoIkNJT/5gBkOd73Dzhk=;
        b=PF9tjZCkJh1M+IwD4KQLakI+AGt1UMQJebTKI3m8ixbo6TMg4L75XdCgN9fo7KA7uf
         /qvHtn4htkcytLdWTuoH9la0DQEB4LEIZRIx09JBIwAtc6hEFNxiyCm8Va+4fYt5v1Zc
         Ivrj7699kuBMf5tXAXPCozWwqoRFEEN1iM+/cegYpDT7vB0KssD/2N/33DqDhmCZHpzb
         3GK5dgXFWhKZJvhvjhvNbvh5goPKQlRjb/AuK322fj501o+nzB3bGGhdiGq76MG+9yOl
         arKyfPuhqJnYW4CZH6aQ636vdDGHKonVsi123q94gs6Tfi/3UaX3cc5HJZh3NaLraMI4
         phWA==
X-Gm-Message-State: AO0yUKX5/p0fJZBnNBzr7Jh7BRWFmmP4FCiXDUNNpdne9AuG8F7b18vj
        3On4FRsDtR4GmaRT+Hyx6nw=
X-Google-Smtp-Source: AK7set9v7wgfuKd5vWk9f/V+g771oktAijHifRK/8sWE88Bfmjt7S6cryPKpkXpWwONL9jVAl3Xieg==
X-Received: by 2002:a17:907:118b:b0:939:c395:1b3 with SMTP id uz11-20020a170907118b00b00939c39501b3mr11028438ejb.31.1679582709113;
        Thu, 23 Mar 2023 07:45:09 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b00931faf03db0sm8458743ejb.27.2023.03.23.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:45:08 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: cbb: remove linux/version.h
Date:   Thu, 23 Mar 2023 15:45:05 +0100
Message-Id: <167958269200.541422.1665611551980712106.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230303130346.2062989-1-usama.anjum@collabora.com>
References: <20230303130346.2062989-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Fri, 3 Mar 2023 18:03:46 +0500, Muhammad Usama Anjum wrote:
> make versioncheck reports the following:
> ./drivers/soc/tegra/cbb/tegra-cbb.c: 19 linux/version.h not needed.
> ./drivers/soc/tegra/cbb/tegra194-cbb.c: 26 linux/version.h not needed.
> ./drivers/soc/tegra/cbb/tegra234-cbb.c: 27 linux/version.h not needed.
> 
> So remove linux/version.h from these files.
> 
> [...]

Applied, thanks!

[1/1] soc/tegra: cbb: remove linux/version.h
      commit: 9737a63558deeec01ce202c6c06c96a0503a3128

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
