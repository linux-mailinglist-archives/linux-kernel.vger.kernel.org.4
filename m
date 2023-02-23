Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB66A100C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjBWTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjBWTDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:03:08 -0500
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335DD869E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:03:00 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 658D2C8008D;
        Thu, 23 Feb 2023 20:02:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id sTEe5keq6-lp; Thu, 23 Feb 2023 20:02:58 +0100 (CET)
Received: from [192.168.176.165] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 32B14C8008A;
        Thu, 23 Feb 2023 20:02:57 +0100 (CET)
Message-ID: <edafaf88-cf58-8cc0-8466-aa14794e8673@tuxedocomputers.com>
Date:   Thu, 23 Feb 2023 20:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Add quirk to disable PSR 2 on Tongfang PHxTxX1 and
 PHxTQx1
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     "Hogander, Jouni" <jouni.hogander@intel.com>,
        "Souza, Jose" <jose.souza@intel.com>,
        "Santa Cruz, Diego" <Diego.SantaCruz@spinetix.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Kahola, Mika" <mika.kahola@intel.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>
References: <20230222141755.1060162-1-wse@tuxedocomputers.com>
 <9b0e29f15f3e8799256c425f06b36a70ec04522f.camel@intel.com>
 <52f48cb2-ce54-854f-3bec-44c40c6ad07f@tuxedocomputers.com>
In-Reply-To: <52f48cb2-ce54-854f-3bec-44c40c6ad07f@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 23.02.23 um 19:56 schrieb Werner Sembach:
>
> Am 23.02.23 um 19:26 schrieb Hogander, Jouni:
>> On Wed, 2023-02-22 at 15:17 +0100, Werner Sembach wrote:
>>> On these Barebones PSR 2 is recognized as supported but is very
>>> buggy:
>>> - Upper third of screen does sometimes not updated, resulting in
>>> disappearing cursors or ghosts of already closed Windows saying
>>> behind.
>>> - Approximately 40 px from the bottom edge a 3 pixel wide strip of
>>> randomly
>>> colored pixels is flickering.
>>>
>>> PSR 1 is working fine however.
>>>
>>> This patchset introduces a new quirk to disable PSR 2 specifically on
>>> known
>>> buggy devices and applies it to the Tongfang PHxTxX1 and PHxTQx1
>>> barebones.
>> I've been thinking something similar as there is still at least one
>> issue which seems to be like panel side issue:
>>
>> https://gitlab.freedesktop.org/drm/intel/-/issues/7836
>>
>> Did you considered dpcd_quirk_list in drivers/gpu/drm/drm_dp_helper.c?
>>
>> I'm not sure which one is more correct though...
> Imho, since the proper fix lies within the Intel driver the quirk should also 
> lie within the Intel driver, because even if the panel has the same problem 
> combined with an AMD or NVIDIA card the proper fix for them will most likely 
> be land in the same kernel version. So there could be a period where you no 
> longer want the quirk for devices combining the panel with an Intel gpu but 
> still with an AMD GPU or vice versa.
*the proper fix for them will most likely not be in the same kernel version.
>>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>> Cc: <stable@vger.kernel.org>
>>>
>>>
