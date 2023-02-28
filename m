Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF636A60BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjB1Uwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB1Uwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:52:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C865B9F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:52:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so3787483pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677617558;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyXGNk7FlexKacBj27dEmckMTH6sMBWrOvXXLtAiEoo=;
        b=doQrXDAt1jwGttVG1vfvs789T37zM1/lMF20VuG7CoABnUShbPV9s3t5pAUkbRFUM+
         7cQ8Ww0R/CjisJ3F5CR9xPIBaee7+RDnZEfhvpopDhq9haJYY82JPgOV86DGXW74PRBD
         0WN0JG1ZYjdFZrv0znpA+uQzcewroNsYVdIBpkNpkAVRARAGW74r+jRv6Nv48tQcQpyq
         6Akktzzu/8MntkD23vDR6kg7kh+1ZXxtOxdTK5rIOhZKUN8L+azf7inM9LbLDJ/z7ffJ
         6kcz4kjg9kGsyjvjBV4VOZKbzE6RJhyNFYtfpsIDmk1Ay4k52rr9LaRSp/EKNCPVG8KX
         j9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617558;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyXGNk7FlexKacBj27dEmckMTH6sMBWrOvXXLtAiEoo=;
        b=f5N9OXGB8G3nu9/f6kirnTqmhVrb4wWv5eFuSBSSyv6RlMtZkWHfHqJRvWF+XpiOIl
         mDChMA3plqnxtegadtrk8Sxv2gGg7I2l1/XUc5yUC0UyZRg0Wqg+6zRmZOb7i6im/R7T
         84jPnnmkKu57T2w7yREjTSRAynoizr844QAmuST4WCKhzZ008ocQaW5WwR5BQeJFMn8+
         xHqgHRcecG9pwneV1vsZgxpBVF33maB/0t+qEv2UC8Hzm9Z/1FBYYTdgak3/9JUGu10e
         K4yfjvYEn1tNEMMFmivCowJg6IR7ctYDLUM38R622R7fE2/gzWLXdYbEp4sbqNhIORBQ
         itaQ==
X-Gm-Message-State: AO0yUKXFYvWlvglbojF8gkHD+cWRLTVtvF/5DQ120Yqr0kiEpMWD0r+H
        fg23bXj+ECZhZUZCOVgNZaAiZXrS01dm8fMZ
X-Google-Smtp-Source: AK7set9eplo/mJu3gJ6BJKisU0RdvtBkHBwbUJ6DNSAdFWZH2D5//FwQKucGz6zbCzK0Al2v281cRg==
X-Received: by 2002:a17:902:fb84:b0:19e:2fe5:40c7 with SMTP id lg4-20020a170902fb8400b0019e2fe540c7mr3603203plb.48.1677617558638;
        Tue, 28 Feb 2023 12:52:38 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902714d00b00198e7d97171sm6914875plm.128.2023.02.28.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:52:38 -0800 (PST)
In-Reply-To: <20230208225328.1636017-1-heiko@sntech.de>
References: <20230208225328.1636017-1-heiko@sntech.de>
Subject: Re: (subset) [PATCH 0/2] Small fixups for the Zbb string functions
Message-Id: <167761750116.11234.7293839788838839450.b4-ty@rivosinc.com>
Date:   Tue, 28 Feb 2023 12:51:41 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, christoph.muellner@vrull.eu,
        ajones@ventanamicro.com, Heiko Stuebner <heiko.stuebner@vrull.eu>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Heiko Stuebner <heiko@sntech.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 23:53:26 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> I didn't manage to address Andrews comments on v5 [0] in time
> before the series got applied, so here are two addon comments
> that hopefully do his comments justice now.
> 
> 
> [...]

Applied, thanks!

[2/2] RISC-V: improve string-function assembly
      https://git.kernel.org/palmer/c/6934cf8a3e0b

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

