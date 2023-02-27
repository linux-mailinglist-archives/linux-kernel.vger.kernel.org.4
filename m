Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA76A4897
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjB0Rvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0Rvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:51:31 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF9510ABA;
        Mon, 27 Feb 2023 09:51:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7428F604E9;
        Mon, 27 Feb 2023 18:51:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677520282; bh=YdTE5lDjvSSCYH2seOlusLqO3HeakuTrMpKlRWsfD7U=;
        h=Date:To:Cc:From:Subject:From;
        b=PsaigPuDqLpEVTR5iDmXZmLDHZ+pa5Bm8yWi73hCBBxJ84N5SK8UOGCRQ85A27LcO
         3IAHHadhCkFpgZFDiwnWKRTedStfiCYKmqVFCTmXBVKPDmHfP3AUVC/RFFxUEapTdp
         cEZiaMrksCMGrPuouGgGpJzQJ2G+7ZZvqku3HfggONDr6jkLioyBpBm5r0dYDnrN87
         uYl3N7uvLp+mZwH+PYbX/dmga1vyUglhTo87kC9+NoeTomxmUAeU2Zqz8QK6vgsl+S
         8hd71trlysAulyw41ErQDQfLAY1/FFYjsw7Z1cpOgIZapUYWdRXKoIVd11JRRmnDGD
         E/pKP09rQBflw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7lCOyHGiZN8z; Mon, 27 Feb 2023 18:51:15 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id B8CEF604EA;
        Mon, 27 Feb 2023 18:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677520274; bh=YdTE5lDjvSSCYH2seOlusLqO3HeakuTrMpKlRWsfD7U=;
        h=Date:To:Cc:From:Subject:From;
        b=rCwgAO6/UwD90lz2DFg8oBL/MAFEn1xTnP3vVmO77p62MjzmoA5JOspIU+zux5aAy
         ck9M6pHcf/mtGc212aVPmTM3gR7yc9+fT59Cr4kTFhGSmRIIiQxJPfPFHGkr7Q3KCI
         07RPmQ+isyO2lnydHrtCN3vcTtGoLB50OIcVJ62OuVp+NQSXfpa9+hp5FO+v7R6Vac
         BeauQSWcXvOUPf+4kCF00VMQcQHFgg4/jT8BXT3b1KaigHNiRLetME00HBLljt0MNc
         ITIqDArIVPm3kKdfULd8J6ojOdMQsY81b5CHT3HDULjnH8QbjAW1bACIUHMQ7g6HCm
         ihxyw5sqgPiuw==
Message-ID: <fe030b8e-0573-93de-88ae-38ee48d6c89f@alu.unizg.hr>
Date:   Mon, 27 Feb 2023 18:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, hr
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: selftests/gpio: gpio-sim.sh: BUG: test FAILED due to recent change in
 sh source
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The gpio-sim.sh test appears to FAIL in a wrong way due to missing initialisation
of shell variables:

$ sudo gpio-sim.sh
.
.
.
4. Simulated GPIO chips are functional
4.1. Values can be read from sysfs
4.2. Bias settings work correctly
cat: /sys/devices/platform/gpio-sim.0/gpiochip18/sim_gpio0/value: No such file or directory
./gpio-sim.sh: line 393: test: =: unary operator expected
bias setting does not work
GPIO gpio-sim test FAIL
$

This patch fixed the issue:

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index 9f539d454ee4..fa2ce2b9dd5f 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -389,6 +389,9 @@ create_chip chip
  create_bank chip bank
  set_num_lines chip bank 8
  enable_chip chip
+DEVNAME=`configfs_dev_name chip`
+CHIPNAME=`configfs_chip_name chip bank`
+SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
  $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
  test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
  remove_chip chip

... after which the test passed:

4. Simulated GPIO chips are functional
4.1. Values can be read from sysfs
4.2. Bias settings work correctly
GPIO gpio-sim test PASS

Which I believe proves that the bug was in the script and not in the gpio-sim driver.
Or I am doing something very wrong, but I got the above error on AlmaLinux 8.7
on my Lenovo desktop box with the 6.2+ latest pull Linux kernel:

[marvin@pc-mtodorov linux_torvalds]$ uname -rms
Linux 6.2.0-mglru-kmlk-andy-09238-gd2980d8d8265 x86_64

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
