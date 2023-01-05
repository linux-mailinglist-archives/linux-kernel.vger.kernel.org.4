Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4865EE76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjAEOLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjAEOLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:11:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40823559C3;
        Thu,  5 Jan 2023 06:11:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBD9EB81AE8;
        Thu,  5 Jan 2023 14:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9825CC433D2;
        Thu,  5 Jan 2023 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672927867;
        bh=TKF/50WPsM6WG6z/BHETGFP0N5897i84bKSxeN2lavY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIgyQ2kNfuWNdzFW1Ecy60rMnwEWLG+l0di09vAycPOQGPHsHHnkuRPmM+s+k9fgQ
         4qj9mDXeBcLiT1tNe69oFeqCPKu8D8E+oMiyf1+j2l9baAnKXlVlM4vnOuOoxSZaB9
         vetSColrEFjDfGFQlky2EotoxLjfo4wNdPA8Vw7pLWf847aUZxbMH0L6wr+pjb0E/6
         i/IWFpJncAiQmNuE02rz9ScKAdmeDyJ2WKQGYZvPyVnCx5RuxuxWsemfwSCCDGcOlI
         92AtJpc6pW9wog0wlvPMb1RYc7Tpip4d92VMRI/6Z5PBfYWAhJwOijkZg8AIaeUF7q
         SqeC5vpbZzXnA==
Date:   Thu, 5 Jan 2023 14:11:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, krzysztof.kozlowski@linaro.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com
Subject: Re: [RESEND PATCH v5 0/2] Add LED driver for flash module in QCOM
 PMICs
Message-ID: <Y7badoCDWiENrzVI@google.com>
References: <20221227081523.2277797-1-quic_fenglinw@quicinc.com>
 <9a0d7b7c-53bb-cfa6-8629-a0c48b70364f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a0d7b7c-53bb-cfa6-8629-a0c48b70364f@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Fenglin Wu wrote:

> Hi Pavel, Jones,
> 
> Can you help to review the new flash LED driver changes for Qcom flash LED
> module when you are available? It's pending for while.
> Thanks

The patches I have in my inbox are from last week.

Please be patient - my backlog is presently very large.

You're 'on the list'.

> On 2022/12/27 16:15, Fenglin Wu wrote:
> > Initial driver and binding document changes for supporting flash LED
> > module in Qualcomm Technologies, Inc. PMICs.
> > 
> > Changes in V5:
> >    1. Add MODULE_DEVICE_TABLE for auto-loading.
> > 
> > Changes in V4:
> >    1. Added Tested-By tag.
> >    2. Addressed review comments in the binding change and added
> >       Reviewed-by tag.
> > 
> > Changes in V3:
> >    1. Updated the driver to use regmap_field for register access.
> >    2. Adressed the review comments in binding document change.
> > 
> > Changes in V2:
> >    1. Addressed review comments in binding change, thanks Krzysztof!
> >    2. Updated driver to address the compilation issue reported by
> >       kernel test robot.
> > 
> > Fenglin Wu (2):
> >    leds: flash: add driver to support flash LED module in QCOM PMICs
> >    dt-bindings: leds: add QCOM flash LED controller
> > 
> >   .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 +++
> >   drivers/leds/flash/Kconfig                    |  15 +
> >   drivers/leds/flash/Makefile                   |   1 +
> >   drivers/leds/flash/leds-qcom-flash.c          | 701 ++++++++++++++++++
> >   4 files changed, 833 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> >   create mode 100644 drivers/leds/flash/leds-qcom-flash.c
> > 

-- 
Lee Jones [李琼斯]
