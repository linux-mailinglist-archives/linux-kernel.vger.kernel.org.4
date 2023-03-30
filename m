Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D936D099E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjC3Pbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjC3Pbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:31:34 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDF0CA0C;
        Thu, 30 Mar 2023 08:31:18 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id l7-20020a4abe07000000b0053e1205c84bso2658268oop.9;
        Thu, 30 Mar 2023 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnDjYGmEqOEcX6BV3D3Xoo9yGR2TRiur28JejHxdE3w=;
        b=pTD4y+W8fF1+NtRJ6Sl80ayFjxvhl97qVLcgqNTvNEpWizlvCdAat9w7UOjnnQgVE6
         FyNK04O6vyKVGG4gQ0T/X55WooCsqgCTQOQzuOOpdwgR6F0/NXmslBMSVskhyw8e+ilu
         Hj3nhhnJK8tWHT0xph19tVok6dCW9ytsDC7goRxCPKsZphE4rHValCe6K6uCR7WXLGpI
         g78jXZoHdEFxHKmoFK0ReN8O8r9AUCssQVzVSO6tcQeGfSX+BOKj/BFVCIsPSd9W1OOw
         20+k1JVkP3SGrVEYcMIp/IzBuRDEuW9vLDaH3xOxzq7YlsDzKX7BxyywcUhQXAH4dvFs
         n7og==
X-Gm-Message-State: AAQBX9do2ssw9/d8katdmfthWgDBLc9h/zbphiVVLWGTpPr45xsrdpyF
        n9QjG6LF04TUOvRRY9Ew1Q==
X-Google-Smtp-Source: AKy350abjVDUmX8OWlEBXnmhH2hwWTbeugExUUvnY6Mez9tAhkValHyWVltMFvpiHlfSl2td0DikgQ==
X-Received: by 2002:a4a:bd8c:0:b0:53c:5f89:eb85 with SMTP id k12-20020a4abd8c000000b0053c5f89eb85mr3363326oop.2.1680190277775;
        Thu, 30 Mar 2023 08:31:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o79-20020a4a2c52000000b0053b8ae294f3sm9069976ooo.11.2023.03.30.08.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:31:17 -0700 (PDT)
Received: (nullmailer pid 2213086 invoked by uid 1000);
        Thu, 30 Mar 2023 15:31:16 -0000
Date:   Thu, 30 Mar 2023 10:31:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: usb: gpio-sbu-mux: Add OnSemi
 NB7VPQ904M mux
Message-ID: <20230330153116.GA2181381-robh@kernel.org>
References: <20230321-topic-sagami_dp-v1-0-340c8bce4276@linaro.org>
 <20230321-topic-sagami_dp-v1-1-340c8bce4276@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321-topic-sagami_dp-v1-1-340c8bce4276@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:12:28PM +0100, Konrad Dybcio wrote:
> The OnSemi NB7VPQ904M Type-C DP altmode redriver provides SBU signals
> that can be used in with the gpio-sbu-mux driver. Document it.
> 
> Note that the -mux suffix is there to indicate that the gpio-sbu-mux
> driver interacts with the mux part of this otherwise quite sophisticated
> chip, leaving the "onnn,nb7vpq904m" compatible free for when a proper
> driver taking care of all of the chip's capabilities is introduced.

You should define a proper and complete binding. If you want to bind the 
gpio-sbu-mux driver to it now until you have a proper driver then that's 
fine. When you have such a driver, then you drop the compatible from the 
gpio-sbu-mux driver.

Note that having the fallback "gpio-sbu-mux" is somewhat problematic 
because the kernel has no mechanism to ensure you bind the most specific 
driver. For that to happen, it would have to support (automatically) 
unbinding one driver and binding to the more specific driver since one 
driver could be built-in and the other a module.

Rob
