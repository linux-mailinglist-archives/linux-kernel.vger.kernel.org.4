Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3785B6EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiIMOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiIMOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:05:58 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F3E19001;
        Tue, 13 Sep 2022 07:05:56 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 162B261EA1932;
        Tue, 13 Sep 2022 16:05:53 +0200 (CEST)
Message-ID: <02604223-af8a-a86f-8873-19a4dbb3035b@molgen.mpg.de>
Date:   Tue, 13 Sep 2022 16:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        Hans de Goede <hdegoede@redhat.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: boot performance: ACPI delays in boot up of Alder Lake laptop (Dell
 XPS 13 9315)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Just a heads-up, on the Dell XPS 13 9315 over half a second during boot 
seem to be due to delays in firmware provided ACPI/ASL.

     […]
     [    0.000000] DMI: Dell Inc. XPS 9315/02GGG1, BIOS 1.1.3 05/11/2022
     […]
     [    0.220268] ACPI: PM: Power Resource [D3C]
     [    0.472079] ACPI: PM: Power Resource [PIN]
     […]
     [    0.512316] pci 0000:00:07.1:   bridge window [mem
0x74000000-0x960fffff]
     [    0.512319] pci 0000:00:07.1:   bridge window [mem
0x6040000000-0x6075ffffff 64bit pref]
     [    0.888002] ACPI: EC: interrupt unblocked
     [    0.888002] ACPI: EC: event unblocked
     [    0.888062] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
     [    0.888062] ACPI: EC: GPE=0x6e
     […]

I created two bug reports [1][2] for each of these delays. 
Unfortunately, the device is used in production by a user, so I can’t do 
any testing.

Linux taking less than 0.5 seconds to execute on modern consumer 
hardware still should be a goal in my opinion.


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=216481
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=216482
