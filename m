Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0A5F28F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 09:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJCHEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 03:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJCHEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 03:04:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6F34704
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 00:04:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u24so1928995plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=Jcb3UBBRzz+mGxXYoE2+emv0xptsMTPozlXn5m1i4W8=;
        b=N+rVwqMabhmxD8pIXwz/aVabWlGDyVggecTor4pV2g6UnfdhatAY4k3yl4wO98ZNfF
         a5McjKhjjdF3ibhdHmIGqcpg/jY5ffsrJyUnoevXC03WUY9v1izlQ/zx8LUtUdS45t5T
         GNqINUu/Qe437UUnwlEbjHFH1zRB7kJZRhj2ERboX5mnKf6rq6qlgUyWFic9o4KliFNw
         AMiXohlUkoTiqjqc8dnf01W+3f9pf6wRxCejvrqIXvj86VczTMXtENSNH/ejzxGy2iFS
         TXppcDEq2kiwydHXBmKa2ML3vJQJUXUQJIo5Vxm/3FJxEs76prujPaL2j5bIIKAsOyat
         zfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jcb3UBBRzz+mGxXYoE2+emv0xptsMTPozlXn5m1i4W8=;
        b=YIqwRL3xye6gFnqka1eqVOoaLuHTDcyCKqlzRX3ayciKsCpZl/e5jCkcX44MlxRUyv
         jD137/Q7A5o583i9tEpW2+aGCSgHcp30s3Vl0mZVLReupPvi/vIKjMFLUZ6B1Dt6zIi9
         RT/Ly1dkAkPhyXVwV2b3Pzw7sO+GgGlCB+aw8QkiW8kY1uNmFXPiRH8JGNCeHYNlPPRu
         6MeyfMiYG45wsqAsejSOYFACJwfTLEFBDhKzCE/4iDX1EqR0PqN2ykzks0HshTJn3yyc
         L6We0OSCMyeWHjiHqxitDMmeW6B02LHo0zR54mhQXvyoTs+6xg/nWg+utSYi9DqX1Lhy
         y3sg==
X-Gm-Message-State: ACrzQf3F9yZvi2zCmJz2hHi9k7cHtjF1LbxMBb0ROYQ+ayhybMIARgRn
        Vb2J3pzhOfuk1cLnktucNLfX
X-Google-Smtp-Source: AMsMyM7D4iiJFu/+i+8olYH+0b+Wf+Ao6TXBxAphSavaF8S5gy8jINq4ng0gwpXE+DiZYA+RrINpCQ==
X-Received: by 2002:a17:902:e744:b0:178:6d7b:6d08 with SMTP id p4-20020a170902e74400b001786d7b6d08mr21355787plf.128.1664780660195;
        Mon, 03 Oct 2022 00:04:20 -0700 (PDT)
Received: from thinkpad ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id mn23-20020a17090b189700b00205d70ccfeesm6979092pjb.33.2022.10.03.00.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 00:04:19 -0700 (PDT)
Date:   Mon, 3 Oct 2022 12:34:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH v3 0/5] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <20221003070415.GC5398@thinkpad>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:08:54AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series fixes the crash seen on the Qualcomm SM8450 chipset with the
> LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
> fixed LLCC register offsets for detecting the LLCC errors.
> 
> This seems to have worked for SoCs till SM8450. But in SM8450, the LLCC
> register offsets were changed. So accessing the fixed offsets causes the
> crash on this platform.
> 
> So for fixing this issue, and also to make it work on future SoCs, let's
> pass the LLCC offsets from the Qcom LLCC driver based on the individual
> SoCs and let the EDAC driver make use of them.
> 
> This series has been tested on SM8450 based dev board.
> 

Since the LLCC patches are already merged, can we get the EDAC patches to be
merged for v6.1?

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Instead of using SoC specific register offset naming convention, used
>   LLCC version based as suggested by Sai
> * Fixed the existing reg_offset naming convention to clearly represent
>   the LLCC version from which the offsets were changed
> * Added Sai's Acked-by to MAINTAINERS patch
> * Added a new patch that removes an extra error no assignment
> 
> Changes in v2:
> 
> * Volunteered myself as a maintainer for the EDAC driver since the current
>   maintainers have left Qualcomm and I couldn't get hold of them.
> 
> Manivannan Sadhasivam (5):
>   soc: qcom: llcc: Rename reg_offset structs to reflect LLCC version
>   soc: qcom: llcc: Pass LLCC version based register offsets to EDAC
>     driver
>   EDAC/qcom: Get rid of hardcoded register offsets
>   EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
>   MAINTAINERS: Add myself as the maintainer for qcom_edac driver
> 
>  MAINTAINERS                        |   3 +-
>  drivers/edac/qcom_edac.c           | 119 ++++++++++++++---------------
>  drivers/soc/qcom/llcc-qcom.c       |  92 +++++++++++++++++++---
>  include/linux/soc/qcom/llcc-qcom.h |  36 +++++++--
>  4 files changed, 170 insertions(+), 80 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
