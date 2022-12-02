Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93B64010C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiLBHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiLBHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:32:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7401A208
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:32:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 21so4171684pfw.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 23:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XMc+fVt7lMfpPfThQ2LlpZjE3HoFIHWqL+MbvHeGkEw=;
        b=oplmIpKFwFcFi6/ERjvfl0+tQ/V8jWbzFESczzbKPDTgQVNfrp3vRG7+gCT0Z/b5+x
         xD49t/+X9FZqYePZCmfUzwJ76isJLV2MfDBd8TIa14UmO2p+8T8TfJyMoVVbqop8j3Y1
         c9whpqskeIMG7M5bClR1rdr9+J7TL13EmVakLaTb5DnZ3jHD+EYCrMC3Cz0UOtkIgSz+
         eKLOo6caI46pIEkRUIOPeVIR+Yrv6vg6EcXZjfgGIzy8TJ+03Rmh6K5+CUWJIxhocDCu
         A9HSaXvtbQoZswTpzajRjLWm5edk/rbuNicq/DUsB7ivUAbrOmBS7DcgUqSSzWGDkgSL
         uZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMc+fVt7lMfpPfThQ2LlpZjE3HoFIHWqL+MbvHeGkEw=;
        b=lEU7DaBMBfexbQuNB5ErA+JEB4hGwlyaUsenzIgbUd8K0BPWZ9aDZMBae7A+7BpRYZ
         bfDmCU/GDCqD1GNI4Dvr3mBoTiecaqKFVt1q+S46/SuDGR2TXhQCd16HTmsQA0nSm0jQ
         ZVQastuE6XA88iz0XgaUVaDm9AxEegSRsuJmylZlgwYoI2KiEIj+bQOcs/vXinDewN07
         e+vAlD4Yv7bPmsd34E4VjrVKzvXVVDXxJK25tW5lUbcPo2YAa5ERR9E1wxDAB11UrhBh
         9exkAWRRGfG3iuNsTxHzTwHWBk5s0U/lB9JJWI7kHl9xm4f9MFmH3QQ1lRHUZu5OQ6HW
         MX4g==
X-Gm-Message-State: ANoB5pmTEeyd7tRLgsUS/9vYJModiWAU9cbV0hXE0fpvt1LtHu6ibg4R
        xK8w105tausqwGOxnjf8hjWF
X-Google-Smtp-Source: AA0mqf7qXeTcy+fGt0iYZFNf/ZVn4x0iMUwzgp35UZl85c396Ki0j3U9GoxMup5q3KyaRCUXr3odpg==
X-Received: by 2002:a63:f80a:0:b0:478:427a:85f0 with SMTP id n10-20020a63f80a000000b00478427a85f0mr14001019pgh.124.1669966360305;
        Thu, 01 Dec 2022 23:32:40 -0800 (PST)
Received: from thinkpad ([27.111.75.154])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b00189bf5deda3sm317712plb.133.2022.12.01.23.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 23:32:38 -0800 (PST)
Date:   Fri, 2 Dec 2022 13:02:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com
Subject: Re: [PATCH v4 18/23] scsi: ufs: core: Add reinit_notify() callback
Message-ID: <20221202073231.GA5356@thinkpad>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
 <20221201174328.870152-19-manivannan.sadhasivam@linaro.org>
 <fa0e6167-a893-4eb7-efff-8f378ee819e1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa0e6167-a893-4eb7-efff-8f378ee819e1@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:05:57AM -0800, Bart Van Assche wrote:
> On 12/1/22 09:43, Manivannan Sadhasivam wrote:
> > reinit_notify() callback can be used by the UFS controllers to perform
> > changes required for UFS core reinit.
> 
> What does "UFS core" refer to in this context? Should "UFS core" perhaps be
> changed into "UFS controller phy"?
> 

By "UFS core" I meant the UFSHCD driver. Will change it.

> > diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> > index 5cf81dff60aa..af8c95077d96 100644
> > --- a/include/ufs/ufshcd.h
> > +++ b/include/ufs/ufshcd.h
> > @@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
> >    * @config_scaling_param: called to configure clock scaling parameters
> >    * @program_key: program or evict an inline encryption key
> >    * @event_notify: called to notify important events
> > + * @reinit_notify: called to notify UFS core reinit
> 
> Please make this comment more clear. Nobody knows what "UFS core" means.
> 

Will change it to "called to notify reinit of UFSHCD during max gear switch"

Thanks,
Mani

> Thanks,
> 
> Bart.
> 

-- 
மணிவண்ணன் சதாசிவம்
