Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC03733187
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjFPMpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345392AbjFPMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:45:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E713AA3;
        Fri, 16 Jun 2023 05:45:12 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25EC3AB;
        Fri, 16 Jun 2023 14:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686919479;
        bh=OaUTs1pNl8tcjN/wLLanDbgabdIQzVRUuZtiL15s//E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FAIt915C39boke8VUYI/TIFdf8Y7IDDjbcl/6yaqI3cNzTNaoLnA4LdtDVp9yo/Kb
         3FpOxTNqYNgw2umuspnEXOf+Y7wF3BHlBtO173s81zxb5OAvdgnz233aPksD88jwXe
         nT2mfvM8qmj8CtK3+u19IKLCam9f5VMO2q4hSj4c=
Message-ID: <5eb55b7d-f1e9-0dbe-cbbf-bd27ae521e5f@ideasonboard.com>
Date:   Fri, 16 Jun 2023 15:45:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 2/2] drm/tidss: Add support for AM625 DSS
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230608163734.2578-1-a-bhatia1@ti.com>
 <20230608163734.2578-3-a-bhatia1@ti.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230608163734.2578-3-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/06/2023 19:37, Aradhya Bhatia wrote:
> Add support for the DSS controller on TI's AM625 SoC in the tidss
> driver.
> 
> The AM625 DSS supports 2 video planes connecting to 2 video ports.
> The first plane is a full plane supporting all the features, while the
> 2nd plane is a "lite" plane without scaling support.

The DRM planes are reversed compared to the HW planes, aren't they? Is 
the above referring to HW planes?

> The first video port in AM625 DSS internally provides DPI output to 2
> OLDI transmitters. Each OLDI TX outputs 4 differential lanes of video
> output and 1 of clock output.

I think it should be explained that OLDI is not supported in this 
version, but will be added later.

Other than that:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

