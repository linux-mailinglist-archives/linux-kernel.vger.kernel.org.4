Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACF6D6550
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjDDO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjDDO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:28:06 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB32710;
        Tue,  4 Apr 2023 07:28:05 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id bh15so5244897iob.9;
        Tue, 04 Apr 2023 07:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71umLAT2jkhfp2o7IPOP9wVmIgDT1dmQMyKI5gOIuH8=;
        b=HtAUkS3j5x9SLorCSYsYTvhCL7YFqCpukj7JJeUHQ37NXqruPRHkskNmF+iS5jp1Nt
         FVWhwvTV5JclTpuwY10mdi6a3L6f+kgKQavS5Xe6SyUmetZ/TXsX2p680Z6eGyLdDWAi
         rxxGkVr8CfohiJujXgKHHdR7PJGtBUDM7+GyztQY4TNpGB8onokGjvWC/YVu69UWqQZg
         JftY22Dm2ieab2gIKX52eHszNqT2UCv0fFtx2gOMqwVE5QMGbNGkKV7Q9cA5JVJpVvSl
         0hDmdNbAX0KFSQ4exh1x+iWCLZ9Ap2WzzytpyiTszE1Y60yKrX0Hp33SzeOfQyLAZNxw
         C+5w==
X-Gm-Message-State: AAQBX9f0xClGgvtdWXHzp7a+x3Vj6OpH9zpgUtaok/j0aff9Lqu1qrv9
        jem4dVXQ1gDeVBO+jSXjFw==
X-Google-Smtp-Source: AKy350Z3r70aQUMvZYIzIbj3potVlVW/qC+wJV1Oav0EJWh7TuQiGkFYk2XSEzWmoaQ78GUGK7yRgw==
X-Received: by 2002:a5e:c10f:0:b0:758:dc2b:d40d with SMTP id v15-20020a5ec10f000000b00758dc2bd40dmr2519989iol.3.1680618484561;
        Tue, 04 Apr 2023 07:28:04 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s7-20020a6bd307000000b0071d93cda853sm3398599iob.42.2023.04.04.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:28:04 -0700 (PDT)
Received: (nullmailer pid 3836869 invoked by uid 1000);
        Tue, 04 Apr 2023 14:28:03 -0000
Date:   Tue, 4 Apr 2023 09:28:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: firmware: qcom: scm: Updating VMID
 list
Message-ID: <168061848207.3836797.11117918850745041617.robh@kernel.org>
References: <20230403204455.6758-1-quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403204455.6758-1-quic_gokukris@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 13:44:55 -0700, Gokul krishna Krishnakumar wrote:
> Adding the full list of VMID's, which are used by different clients to
> pass to the secure world.
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
> V3 Fixed comments from V2
> 
> V2 Fixed allignment issues in [1]
> 
> [1] https://lore.kernel.org/lkml/20230328214703.12093-1-quic_gokukris@quicinc.com/
> 
> ---
>  include/dt-bindings/firmware/qcom,scm.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

