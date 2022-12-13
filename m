Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5A64B964
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiLMQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiLMQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:15:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F9201BE;
        Tue, 13 Dec 2022 08:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4AC615E9;
        Tue, 13 Dec 2022 16:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE93C433D2;
        Tue, 13 Dec 2022 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670948118;
        bh=+QlZzhxjAQK3WvK5wUerkvR6XOsjNy3x6wxOqXFZ3Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zkh7T53mq8kuAhCzmfvGE8uli/Lybl0VCSbfHOtooH09ILeIVnRomD1Iwp5ebWH32
         Kv8xTVE9dbS0TvybihHRZkKcZ3lw6KUSylbqRTue5Y/g4bcETEHL15N/Itlgn+kSKk
         2+luENT0w+I47NhwAzg6UFiFSRU9evuvu44EoSf0Zr4UoRO0sDrYDjCZNq8Z2ZqulD
         wqxJuovFS+hHrbxwoej//3w+MNcQniFDXRFBlaDS2OsalIb+HeZAaJA+orPX/9lqqi
         jHBxuAsERp1J2NiltKKExsyZbQXIv3Ysth0MYu1rCIvJeOXdoIdRzPRl3o7kHbGmjm
         0kOa8uflTsqvA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p57wW-0005m6-Ej; Tue, 13 Dec 2022 17:15:44 +0100
Date:   Tue, 13 Dec 2022 17:15:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5ilMI1QYsx1uaNe@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iWeTk2zOp9rInx@x1>
 <Y5iaDP+nV9B59U2b@hovoldconsulting.com>
 <03252ccd-e200-a112-b4dd-ba9fbf25c480@quicinc.com>
 <Y5icyo7I5ZGAL02q@hovoldconsulting.com>
 <Y5idf5dP2ttBSOUa@hovoldconsulting.com>
 <c2be661a-87e4-864e-3571-75032484f66f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2be661a-87e4-864e-3571-75032484f66f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:44:15PM +0100, Konrad Dybcio wrote:
> 
> 
> On 13.12.2022 16:42, Johan Hovold wrote:
> > On Tue, Dec 13, 2022 at 04:39:54PM +0100, Johan Hovold wrote:
> >> On Tue, Dec 13, 2022 at 09:04:39PM +0530, Shazad Hussain wrote:
> >>> On 12/13/2022 8:58 PM, Johan Hovold wrote:
> > 
> >>>>> So qup2_i2c18 becomes qup2_i2c2. Would I use the flat naming scheme for
> >>>>> the alias like so?
> >>>>>
> >>>>>      aliases {
> >>>>>          i2c18 = &qup2_i2c2;
> >>>>>      }
> >>>>
> >>>> Or perhaps the i2c controllers should use a zero-based index instead of
> >>>> being named after the serial engines (e.g. as we do for the console
> >>>> uart).
> >>>>
> >>>> How are they named in the schematics?
> >>>
> >>> We should use from 0 to N.
> >>
> >> With N being 23 after the number of serial engines, or the number of
> >> available i2c buses on a particular board minus one?
> > 
> > Looks like the more recent Qualcomm platforms use aliases that reflect
> > the engine number (i.e. 0 to 23) for i2c and spi.
> IMO it makes the most sense, as it tells the userspace "hello, this
> device is connected to the physical I2Cn on the SoC" as opposed to
> "hello, this device is connected to the nth enabled bus on this
> particular board".

But I guess it still depends on the board. I wouldn't expect a product
with four serial ports to use the engine numbers on labels for the
connectors for example.

Johan
