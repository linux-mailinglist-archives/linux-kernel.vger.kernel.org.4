Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8A6D9AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbjDFOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbjDFOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:44:08 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F32A265
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680792157; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lhFsL36wim/K65jIXa+gIFWbzebSGbXx5n0fwvKrzfu74fy+ANSpJza+GdIU9UKyFoZCJVYNKmgYQ0SIIzfTGLdnalLYqztpC5qR9ZBNVL7bYuVFBjW2/X0Y+WUEPhTdXSPenswuawwBNRXEcvqcxZph3lae73tX+axRaaGLj9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1680792157; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=U4WFoqaG/WTz/rldWrbpYj6I6++dLC1ugFzEHCLlJ1M=; 
        b=OBesM/jnC1O+4SAh5OVj0rUVc7PWoewWj/rr8j/E9QoARht+Agr+F4MVaGi7OkZfjHM0CpfGRf7lgHkmVWQLvyG8DJ1b6yZsxm/W5+7puPDFyRnOBjC7zNo3iFvf352rw/8eVW+5Zb/OTWemejyP7Xp+dM+/ytbD5g6VexFql5A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1680792157;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:From:From:To:To:Cc:Cc:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=U4WFoqaG/WTz/rldWrbpYj6I6++dLC1ugFzEHCLlJ1M=;
        b=Twr9TPaKPpapwK8oz14Qz7EpLcbHKpDu7SfBYDhqq6WwAm7JjIkv/dABRoMMuDeX
        NynZnpBrGVI0koHOX3mPiQBXKzURu9fu4yMpkP3A9d5qZntMHdcnv1N+NMn14QqnBjb
        9whSaKFYV1zxQ8erZcA9ORHqJ64+99XNRGt0RacE=
Received: from [10.10.10.248] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1680792155340132.56001297566422; Thu, 6 Apr 2023 07:42:35 -0700 (PDT)
Message-ID: <3c1eda4a-2dfc-a0d0-d4f5-8b475440a21e@arinc9.com>
Date:   Thu, 6 Apr 2023 17:42:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        wulcato@gmail.com
Content-Language: en-US
Subject: Computer Audio Appears on Input Device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Me and my friend have got a problem with the computer audio being sent 
to the receiver as if the headphone microphone hears it.

I've got a generic headphone with a microphone. It's got a single jack.

When I plug it to the laptop two devices are detected. Headphones for 
output, microphone for input.

As an incorrect behaviour, the computer audio appears on the input 
device along with output. The expected behaviour should be the audio 
appears only on the output device.

I tried this on my laptop and headphone while my friend tried it on 
their laptop and headphone.

I've tried it on Linux v6.3-rc5 while my friend tried it on v6.1.

My laptop has got this audio device:

00:1f.3 Multimedia audio controller: Intel Corporation Comet Lake PCH-LP 
cAVS

My friend's laptop has got these:

05:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h 
HD Audio Controller

05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir 
Radeon High Definition Audio Controller

I assumed this was a problem with the HD-Audio Controller driver on 
Linux as I don't see this behaviour on Windows 10. The drivers on 
Windows 10:

AMD High Definition Audio Device 10.0.1.24
Realtek (R)  Audio 6.0.9132.1

What could be causing this behaviour on Linux?

Thanks.
Arınç
