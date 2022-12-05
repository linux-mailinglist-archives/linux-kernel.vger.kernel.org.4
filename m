Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62145642D06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiLEQiH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 11:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiLEQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:37:35 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755881F60A;
        Mon,  5 Dec 2022 08:36:03 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id n1so14168580ljg.3;
        Mon, 05 Dec 2022 08:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj18A3YT1VXcGKwkVQNGdZXvKJxipZMiPmJ3cwUe6+4=;
        b=CVc+Deu73veD7jX/M/LxIauvUd4LmZ8hIhkEmahrWepxRV8aHAKM26hSBWS+ysaYIH
         sF03LDKbwcCDInELewQ4G/O+LcJLzH203KgmlYKNKJLf0CWxTMvwMXp72+sERzD3drqk
         VUa/FB+m7DkUAsgBdUiI2DoJrqf/DOYZVzlUbAtLmNhxVZZ1WAEPSKqg7KX44zpYiwTj
         B5Ja00nG7np3YF1oykX8iEUq0/eZBeUWLuGsUfqAAFxzZunWTqfdjbDu1xV/5V5DeHUY
         lKvA/VZl+G3cawWeMcCQDid/5E8wGKXM9qjZotX0oT01cTJMs/Ud6g6N4MutHOhJ+XtO
         y2dQ==
X-Gm-Message-State: ANoB5pnBIftuZO3cu4bMD6F6KJD+KSExLjgnJmt06xXrl+BwD746QQ7Y
        BOGmbyE2Kfut91E/0mW9hcpuwt6PDTFwpcc2
X-Google-Smtp-Source: AA0mqf6lVA/Cf2jCCKgZDHoH/K8lch6LA/QgqttHYA2+vl//jfF0xXfMTO39Fu8zt90000NsU/Iq9Q==
X-Received: by 2002:a2e:b6c5:0:b0:279:d61b:181 with SMTP id m5-20020a2eb6c5000000b00279d61b0181mr5933409ljo.166.1670258116112;
        Mon, 05 Dec 2022 08:35:16 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l12-20020ac2430c000000b004b523766c23sm2174097lfh.202.2022.12.05.08.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 08:35:15 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id p8so19419726lfu.11;
        Mon, 05 Dec 2022 08:35:14 -0800 (PST)
X-Received: by 2002:ac2:4f0e:0:b0:4a2:9248:e276 with SMTP id
 k14-20020ac24f0e000000b004a29248e276mr26840275lfr.605.1670258114461; Mon, 05
 Dec 2022 08:35:14 -0800 (PST)
MIME-Version: 1.0
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
 <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info> <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
 <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com> <457D8649-B855-43BB-B3AD-334E166FED31@holtmann.org>
In-Reply-To: <457D8649-B855-43BB-B3AD-334E166FED31@holtmann.org>
From:   Dave Chiluk <chiluk@ubuntu.com>
Date:   Mon, 5 Dec 2022 10:35:02 -0600
X-Gmail-Original-Message-ID: <CAMfi-DQXkhG6DSWECpxZ+vH_Qi5boDMx5jNj7v7puLEEXRjUaw@mail.gmail.com>
Message-ID: <CAMfi-DQXkhG6DSWECpxZ+vH_Qi5boDMx5jNj7v7puLEEXRjUaw@mail.gmail.com>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 11:46 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Dave,
>
> can you run iwd and set Country=DE (or US) in its main.conf. I think
> most distros have a 2.0 package of iwd available. With iwd we have
> implemented all the handling and re-scanning to make sure we actually
> get to use 6Ghz is available.
>
> Btw. you can run iwd from its source tree. No need to install it if
> You don’t want to mess up your system. Just make sure to disable
> wpa_supplicant so it doesn’t interfere.

@Marcel, I was able to build iwd from source, but was unable to get it
to run due to dbus namespace conflicts. I don't know enough about dbus
to debug that further.  Running iwd from the archives (v1.26-3), and
setting COUNTRY=US in main.conf did not enable the 6e bands.

I don't think setting the global region is the issue, as iw reg set US
works fine, and results in the following iw reg get.  Even before
$iw reg set US
phy#0 sets itself to the correct region.  I think the issue is that
the bios, or the firmware blob being loaded by the ax211 that has some
bits improperly set that is causing the 6ghz to be disabled by the
kernel before userspace ever gets involved.

_________________snip_________________
$ sudo iw reg get
global
country US: DFS-FCC
(902 - 904 @ 2), (N/A, 30), (N/A)
(904 - 920 @ 16), (N/A, 30), (N/A)
(920 - 928 @ 8), (N/A, 30), (N/A)
(2400 - 2472 @ 40), (N/A, 30), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
(5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
(5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
(5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
(5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
(5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
(57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country US: DFS-UNSET
(2402 - 2437 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-80MHZ, NO-160MHZ
(2422 - 2462 @ 40), (6, 22), (N/A), AUTO-BW, NO-80MHZ, NO-160MHZ
(2447 - 2482 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-80MHZ, NO-160MHZ
(5170 - 5190 @ 160), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS
(5190 - 5210 @ 160), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS
(5210 - 5230 @ 160), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS
(5230 - 5250 @ 160), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS
(5250 - 5270 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE-SCAN
(5270 - 5290 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-SCAN
(5290 - 5310 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE-SCAN
(5310 - 5330 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-SCAN
(5490 - 5510 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE-SCAN
(5510 - 5530 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-SCAN
(5530 - 5550 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE-SCAN
(5550 - 5570 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-SCAN
(5570 - 5590 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE-SCAN
(5590 - 5610 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-SCAN
(5610 - 5630 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, PASSIVE-SCAN
(5630 - 5650 @ 240), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, PASSIVE-SCAN
(5650 - 5670 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS,
NO-160MHZ, PASSIVE-SCAN
(5670 - 5690 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
(5690 - 5710 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS,
NO-160MHZ, PASSIVE-SCAN
(5710 - 5730 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
(5735 - 5755 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-160MHZ
(5755 - 5775 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-160MHZ
(5775 - 5795 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-160MHZ
(5795 - 5815 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-160MHZ
(5815 - 5835 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-80MHZ, NO-160MHZ
_________________snip_________________

I wanted to call out the DFS-UNSET setting on phy#0

Dave.
