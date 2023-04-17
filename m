Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF666E42E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjDQIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDQIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:47:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE94222;
        Mon, 17 Apr 2023 01:47:47 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59674DE6;
        Mon, 17 Apr 2023 10:47:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681721259;
        bh=GktcEwyf2LwQ6NY0LHuBgtJ5WGGHaw1b0hIIRAgA2Q0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m5BRM+SgWPTQUonWy/ReGbOSc++sNjonGnQSxO+O5hR6EIqBQhCe01gimQwtYoZZh
         0rN3MN9cUahvdHwYGqm6xHBnrQ/hYfBNT/4pbGUK/ghnH9eC3yNem+g8vmnQyZTiXM
         VFxdGh/55LnNic0Co82X9r+WIDSvHl+VjOm6MxBI=
Message-ID: <b974c741-9d3e-1229-bcd5-a980035d1fb4@ideasonboard.com>
Date:   Mon, 17 Apr 2023 11:47:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/2] "no-hpd" support in CDNS DP bridge driver
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
        jani.nikula@intel.com, tzimmermann@suse.de, javierm@redhat.com,
        ville.syrjala@linux.intel.com, r-ravikumar@ti.com,
        lyude@redhat.com, alexander.deucher@amd.com, sjakhade@cadence.com,
        yamonkar@cadence.com, a-bhatia1@ti.com
References: <20230405142440.191939-1-j-choudhary@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230405142440.191939-1-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 17:24, Jayesh Choudhary wrote:
> In J721s2 EVM, DP0 HPD is not connected to correct HPD pin on SOC
> which results in HPD detect as always connnected, so when display
> is not connected driver continuously retries to read EDID and DPCD
> registers.

Where is the DP0 HPD connected to? Nowhere? If it's connected to a pin, 
can that pin be used as a GPIO? In other words, do we have a HPD, just 
not with mhdp, or is there just no HPD at all?

  Tomi

