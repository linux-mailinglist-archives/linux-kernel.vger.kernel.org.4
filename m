Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8095469BED0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 07:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBSGfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 01:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBSGfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 01:35:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0381C11654;
        Sat, 18 Feb 2023 22:35:19 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pTdI2-0004KC-7X; Sun, 19 Feb 2023 07:35:14 +0100
Message-ID: <ebfe7e80-91be-b0ce-9679-80ac5161ec1f@leemhuis.info>
Date:   Sun, 19 Feb 2023 07:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     acpi4asus-user@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        jacobecc9@gmail.com
Subject: Bug 217057 - Asus high CPU temperature / low fan speed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676788520;433fa141;
X-HE-SMSGID: 1pTdI2-0004KC-7X
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I look out for reported regression in bugzilla.kernel.org and
normally ignore everything else. But I noticed a newly submitted report
that sounded somewhat bad, that's why I decided to write this mail to
ensure the right people are at least aware of it.

https://bugzilla.kernel.org/show_bug.cgi?id=217057

>  jacobecc9@gmail.com 2023-02-18 21:03:13 UTC
> 
> laptop Asus X415EA (Tiger Lake) is running fan too slow in automatic
> mode even if CPU temperature is over 90C. There are no options in BIOS.
> Windows has software which allows fan to reach high speed with
> performance fan curve. Linux only allows to disable PWM.
> 
> [reply] [−] Comment 1 jacobecc9@gmail.com 2023-02-18 21:45:59 UTC
> 
> [   19.733079] asus_wmi: ASUS WMI generic driver loaded
> [   19.779429] asus_wmi: Initialization: 0x1
> [   19.779476] asus_wmi: BIOS WMI version: 9.0
> [   19.779507] asus_wmi: SFUN value: 0x21
> [   19.779510] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
> [   19.779513] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
> [   19.814908] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input23
> [   19.827710] asus_wmi: fan_curve_get_factory_default (0x00110024) failed: -19
> [   19.827840] asus_wmi: fan_curve_get_factory_default (0x00110025) failed: -19

Ciao, Thorsten
