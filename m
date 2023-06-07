Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C39725639
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjFGHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjFGHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:44:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBED2703
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:41:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-543ae6ce8d1so3037706a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686123696; x=1688715696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PjfFNwe8EaTiGUc0QuU/z5HZzTxOk+LVPPYj8mjsNzM=;
        b=hS/0Qma+MSVMOmezs7ae7p8C6lqEhrJlH4f8w//ca/fANrvQFpvioDvwVaAwPHQSzE
         EL+56AyeCdS0kQd3cWCnJCzDFlyZ0NgUkjIKhc+IBMpxxfgC/UIbczsJD5rvidJWiFP9
         nsxFpkRubavOeHiiEIqmlgS/LCSdacfRd/nv2kdeFYj/T3jfPhrkGiOcxQ8TLNcAk9Mc
         NTiF2gKhlqebuJ/MTHPTamqsd29u40mFj8p5BVVapN6n6TGCmK0Q/ELwrFvNDnVn/Jw5
         JqSy0dBoTifuelcf07VOm2+g3Cg+A5XuT+aYXYH4rcXRsPuNJr31a1KxDYscNwARPcOh
         Q/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123696; x=1688715696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjfFNwe8EaTiGUc0QuU/z5HZzTxOk+LVPPYj8mjsNzM=;
        b=mCmPzzoCyBR+8ZHLn9aLGVVoD1a2JWXZozrnC4RClo5z6sY2cDDjVnFGnwNUBU8Uuc
         ArvqscbaLF2xkkYw5evNVsEswnE2hT+LfNx5ZtDgnQFrKBk4ny32rsku1CYaOUMof3Pe
         tGs+p3y8s+JtkwEDGvhdu14f4Nwzov8Um+AdmY57aYKGwTXRT9oCowoQ4Cv15CM7TPyr
         aBufv9P2WRjDMibWMx44gdqeL3933K3JnOdpHYptZphwj3PKo5hhUrcrTQ1qHv2+dkcz
         K0rSkEW0Pgl1M08nZLXw5fGB4ok07VjhrZDJIS6Vz7BZtqHAlbRaxiMSOyZiSTKdXRb+
         1Q2w==
X-Gm-Message-State: AC+VfDw266yfeBylwxPd60Op4pg7CBv83cB7p4sHeY2LTRoHP+U5zQr+
        SkvgfVf91/0rICZkVXT2009f
X-Google-Smtp-Source: ACHHUZ50Fei3Zw35iH9ZCnQkZU/3FdMXz9ZIxWFCszlfvuqnYaKVV+Vt/Nyt3IqrO4RypPINYFkinw==
X-Received: by 2002:a17:90b:3846:b0:253:49d7:ce19 with SMTP id nl6-20020a17090b384600b0025349d7ce19mr3930719pjb.18.1686123695820;
        Wed, 07 Jun 2023 00:41:35 -0700 (PDT)
Received: from thinkpad ([59.92.97.244])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a1a4800b0023a84911df2sm788372pjl.7.2023.06.07.00.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:41:35 -0700 (PDT)
Date:   Wed, 7 Jun 2023 13:11:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add MHI Endpoint network driver
Message-ID: <20230607074118.GD5025@thinkpad>
References: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
 <c769c95d-e8cb-4cf6-a41a-9bef5a786bb1@lunn.ch>
 <20230607065652.GA5025@thinkpad>
 <CAMZdPi-xJAj_eFvosVTmSzA99m3eYhrwoKPfBk-qH87yZzNupQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZdPi-xJAj_eFvosVTmSzA99m3eYhrwoKPfBk-qH87yZzNupQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:12:00AM +0200, Loic Poulain wrote:
> On Wed, 7 Jun 2023 at 08:56, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jun 06, 2023 at 02:59:00PM +0200, Andrew Lunn wrote:
> > > On Tue, Jun 06, 2023 at 06:01:16PM +0530, Manivannan Sadhasivam wrote:
> > > > Hi,
> > > >
> > > > This series adds a network driver for the Modem Host Interface (MHI) endpoint
> > > > devices that provides network interfaces to the PCIe based Qualcomm endpoint
> > > > devices supporting MHI bus (like Modems). This driver allows the MHI endpoint
> > > > devices to establish IP communication with the host machines (x86, ARM64) over
> > > > MHI bus.
> > > >
> > > > On the host side, the existing mhi_net driver provides the network connectivity
> > > > to the host.
> > > >
> > > > - Mani
> > > >
> > > > Manivannan Sadhasivam (3):
> > > >   net: Add MHI Endpoint network driver
> > > >   MAINTAINERS: Add entry for MHI networking drivers under MHI bus
> > > >   net: mhi: Increase the default MTU from 16K to 32K
> > > >
> > > >  MAINTAINERS              |   1 +
> > > >  drivers/net/Kconfig      |   9 ++
> > > >  drivers/net/Makefile     |   1 +
> > > >  drivers/net/mhi_ep_net.c | 331 +++++++++++++++++++++++++++++++++++++++
> > > >  drivers/net/mhi_net.c    |   2 +-
> > >
> > > Should we add a drivers/net/modem directory? Maybe modem is too
> > > generic, we want something which represents GSM, LTE, UMTS, 3G, 4G,
> > > 5G, ... XG etc.
> > >
> >
> > The generic modem hierarchy sounds good to me because most of the times a
> > single driver handles multiple technologies. The existing drivers supporting
> > modems are already under different hierarchy like usb, wwan etc... So unifying
> > them makes sense. But someone from networking community should take a call.
> 
> 
> Yes, so there is already a drivers/net/wwan directory for this, in
> which there are drivers for control and data path, that together
> represent a given 'wwan' (modem) entity. So the generic mhi_net could
> be moved there, but the point is AFAIU, that MHI, despite his name, is
> not (more) used only for modem, but as a generic memory sharing based
> transport protocol, such as virtio. It would then not be necessarily
> true that a peripheral exposing MHI net channel is actually a modem?
> 

Agree, mhi_*_net drivers can be used by non-modem devices too as long as they
support MHI protocol.

- Mani

> Regards,
> Loic

-- 
மணிவண்ணன் சதாசிவம்
