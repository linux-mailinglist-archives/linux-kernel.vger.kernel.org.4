Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B246D3066
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjDALzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDALzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:55:06 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B012545B;
        Sat,  1 Apr 2023 04:54:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 295CF604F3;
        Sat,  1 Apr 2023 13:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680350098; bh=wktZsIqZgEoZxlbnPKAfy7jySjlcBvOPoUk/oBiI7Sc=;
        h=Date:To:Cc:From:Subject:From;
        b=c/HCzqrg1OKXCwkzp9edXWYbdA0sM6zie9t1KnelDoEv+MDAZfYLbUHEyVv8Wuct0
         QRQdxCSYhUWRLPNKqcLzHrBcwYoz87NGjiGQt2KDSBotq3nZ2OgkVMxZVH/kd539cs
         XjX47Uall9UarVYFnDoQNwKjnLOYtZrfDiWFGGcHrqDqMwqzsjcjj7WflekfesdUMR
         zemoHx7DQATVMxx0VDzpBOBlK5wu6TQWz2pSFlmgfJekLHk9tmB9RO49iBQQOoRn1V
         zS1U+gYjci++e81a0R1BoBLLHJHeeORa3K+K5RE5fEAV7gdvrsWKxVARdygctssl3i
         RWpu5OsDcuxIg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id emDkzAQ-alcD; Sat,  1 Apr 2023 13:54:55 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id C7D36604F0;
        Sat,  1 Apr 2023 13:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680350095; bh=wktZsIqZgEoZxlbnPKAfy7jySjlcBvOPoUk/oBiI7Sc=;
        h=Date:To:Cc:From:Subject:From;
        b=JJmsuRYtC5enHtcGkA813CrFL0wQXXyjNBYvwRtPBxMDkAS9We48nz+SPZLKZQLlB
         id7ndE4jQ1IVS1WQwjWfUNC9iNBjvmB3CZwfGqkrnpmge8/cEBy7A1+EeYyQ+dQlvT
         Vf3ol7wpmG9HoNBm6WF/t3Nugh8edjMhDA9M3x9LjVUmDTfXFg7DsQFGzXVBKqsMUD
         17N7IWBLo5tmA625n55c8NT6K7pLZk5whY2P67G0rCqRwqcOjC5kRauMDC7r4xVmbY
         AOB+vohne1LU+uIKRwxdc2T2sSoTiTl58qeiIpY18MQHTfRRKQAMetNhs8QkXe36JZ
         IozQ4SV6Fd3AQ==
Message-ID: <c4c14e20-941d-444e-7390-8624024d3027@alu.unizg.hr>
Date:   Sat, 1 Apr 2023 13:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, hr
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Armin Wolf <W_Armin@gmx.de>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG] Problem with automatic kernel numbering
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mr. Bagas, Sir!

I am talking about a problem with the CONFIG_LOCALVERSION_AUTO=y feature.

I thought of a way to make an exact account of which patches were applied in a build
i.e. adding patch checksum to 6.3.0-rc4-00034-gfcd476ea6a88-dirty, for currently the
command

# rpm -ivh --oldpackage <kernelname>-<build-no>.rpm

install the kernels

kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-24.x86_64.rpm
kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-25.x86_64.rpm
kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-26.x86_64.rpm

all overlapping (apparently everything after '-' [minus] sign is discarded,
so one has to reboot to another kernel, i.e. 6.1.15, remove the offending kernel,
and then install the new one in the sequence of testing.
The CONFIG_LOCALVERSION_AUTO=y rpm build script might add something that rpm
command sees in the install process so the files do not overlap (as kernel names
are being truncated at '-' sign).

A smaller hash of the applied patches would suffice, considering the limit
of 64 chars. Or using an underscore '_' instead of minus '-', so the rpm
installer doesn't treat them as the same version of kernel.

Is this a violation of the build process?

It would be time and energy efficient, for changing the .config and
CONFIG_LOCALVERSION causes much greater recompilation and touches more dependencies.

Optionally, a /proc/<applied-patches-to-build> or something like that could be
added to the running kernel, much like i.e. TuxCare has kcarectl --patch-info
for live patches?

Thank you very much for considering this problem report.

Kind regards,
Mirsad


-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"
