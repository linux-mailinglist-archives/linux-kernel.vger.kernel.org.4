Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7F6F9A8F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjEGR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEGR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:27:45 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B8211603;
        Sun,  7 May 2023 10:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683480449; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W+LLSETWCi1mByV/GeyyJMSiW3CVyJAGSb+5klwZB8TWYQCuzn1oUCFSdK5mM7y3yE
    G1vgcOKjZ45FzDVh4I0OMjda89JCwcyHY4aED04xHF26/omKVsZDSn4f9uVw2e9tnf6P
    hBd9rOC63xN8amQvIBgnViiKQiBOanJ7F4C5uicswEkL3Y5vUz3Gogqus5htgI8ivPzI
    Yaf6pXtdkdzdKNoRwWoztjM4oYL0PeR4wuJGu9gTT5TDyWgGYwgpzdTPQiSm0iS77m5p
    C5DZBIswfxzAWqXGjqr5HgDx8BzIRZqyV7KmmArSLpqJqBF+wFCeYWsZFHv0EqR17Apm
    ktwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683480449;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=t5hLg0/TYuDHYjqBME7pnGaSHDpGH89BUEWNio2GmRg=;
    b=UVIeDU0prfQvgkwQRnrDfROdTxR0aLPQjrmxvgguwAd1Gj6UTrrNnWV1qT07f4O+2b
    A9GLj1Zt5hPJHXYqpzrFBqdBpfc/RXH5BkcoOjD2L5N2ZRVG5BCcoBbhoLe+PQxkQVzC
    gErpMdrtTuN17Mqm3ZkLBAwBmbC/jprjJXuv7z760574WXk7IMsCzXbh1AaWmJgEe3Ji
    XA+caPBYYHJZro3m8eG426qI1kiTFfpjQq0zNeDptKLo2jmDzCyd3sGYtrGZVAd3E9Pe
    ICz3JfMurIHjf2SxZxhYprab3LWPltyzsSN3kN3Vs3/iSU3elpvLk1zzBpXYPFZR0jHW
    1xvg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683480449;
    s=strato-dkim-0002; d=garloff.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=t5hLg0/TYuDHYjqBME7pnGaSHDpGH89BUEWNio2GmRg=;
    b=XNm9B60T9AENbiY59+L3Q8QOeeX6t24Qxbhk0SuWd5x4xXwhLQVhzg9lasVOoidZbs
    tXw1IaNi0lGPfMv+t1XmlTHYMcgxK28oNlERUfHfkt6Xwp59abNWyHP4ZWEB7Q+w1pXF
    +NxvlaLk5DK0E4glPFaovRs0S2JdmYgnsbWdjZVxr0jh6eBHVafGeEq/C7e2RzWIIiCi
    rQeE6mYxxUYcar9PCmmxMaUL6wqAemdJNySQAj3zZ/mkTPNpJNtCugYPdxdLEYeNgSHX
    Zx/bFNI9BQWReAQEqIlJW+4zu23esrislLIFd29z5A00t7QKoowtTkEvwPwCTaAc3x7U
    k+Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683480449;
    s=strato-dkim-0003; d=garloff.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=t5hLg0/TYuDHYjqBME7pnGaSHDpGH89BUEWNio2GmRg=;
    b=RYacnpf7Dvysw936ofs7ApLUlA59lKbbnapHBKCUdQl2egUhNgb660VZbN3sADEnjm
    0Tt6PuYAWrFDBl4cFVAA==
X-RZG-AUTH: ":J3kWYWCveu3U88BfwGxYwcN+YZ41GOdzWdTW9IJoHV1zocjVWQKKeekN8j6tdegf6Miq"
Received: from mail.garloff.de
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id D69cfaz47HRStmo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 7 May 2023 19:27:28 +0200 (CEST)
Received: from [192.168.155.218] (ap5.garloff.de [192.168.155.10])
        by mail.garloff.de (Postfix) with ESMTPSA id 8AFDE5FC23;
        Sun,  7 May 2023 19:27:28 +0200 (CEST)
Message-ID: <0978a8ca-f813-06f5-05d7-2c414ebe6721@garloff.de>
Date:   Sun, 7 May 2023 19:27:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: 6.1.23: 0fc6fea41c71 breaks GPD Pocket 3 modeset
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
References: <4115dc28-45b6-cad1-1e38-39e5a0484a8a@garloff.de>
 <ZFEMkypQy1I4vprK@intel.com>
From:   Kurt Garloff <kurt@garloff.de>
In-Reply-To: <ZFEMkypQy1I4vprK@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

thanks for your response!

On 02/05/2023 15:13, Ville Syrjälä wrote:
> On Sat, Apr 29, 2023 at 09:55:45PM +0200, Kurt Garloff wrote:
>> Hi Ville,
>>
>> While
>> 0fc6fea41c71 drm/i915: Disable DC states for all commits
>> (cherry picked from commit 41b4c7fe72b6105a4b49395eea9aa40cef94288d)
>> does look correct to me, it does break modesetting on the GPD Pocket 3,
>> a i7-1195G7 laptop. I run the kernel with
>> fbcon=rotate:1 video=DSI-1:panel_orientation=right_side_up \
>> mem_sleep_default=s2idle
Note that the mem_sleep_default parm has been dropped meanwhile.
It used to be required as the laptop would show a black screen
after resuming from S3 until 6.1.5 or so.
>> No special i915 parameters.
>> Hardware is described here:
>> https://wiki.archlinux.org/title/GPD_Pocket_3
>>
>> I disected this patch which was merged (backported) for 6.1.23.
>> I currently run 6.1.26 with it reverted.
>>
>> Without reverting it, when fbcon is switched to show the splash
>> screen (GPD logo with Ubuntu added in on working kernels), the
>> screen remains black (backlight on, but nothing displayed) and
>> nothing happens any more.
> Please file a bug at
> https://gitlab.freedesktop.org/drm/intel/issues/new
Find a bug report at

https://gitlab.freedesktop.org/drm/intel/-/issues/8419

> Boot both kernels (revert vs. no revert), passing
> 'drm.debug=0xe log_buf_len=4M' to the kernel cmdline,
> and attach the resulting dmesg from each to the bug.

Getting a boot log out of the crashing laptop required
me to find a cable and get netconsole working.
(If you know better ways, I'm open to learn.)
Thus the delay ...

> Also would be good if you try to reproduce on the
> latest drm-tip (git://anongit.freedesktop.org/drm-tip drm-tip)
> as well.

I'll test drm-tip as requested and see what happens.
I'll attach the info to the bug report, let nme know
if you want eMail in addition.

Best,

-- 

Kurt Garloff <kurt@garloff.de>
Cologne, Germany

