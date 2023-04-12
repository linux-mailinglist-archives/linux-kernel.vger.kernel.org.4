Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14696DF7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDLNwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDLNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:52:33 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C87819BE;
        Wed, 12 Apr 2023 06:52:31 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aebd0.dynamic.kabel-deutschland.de [95.90.235.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E4B1960027FE8;
        Wed, 12 Apr 2023 15:52:27 +0200 (CEST)
Message-ID: <9f1fd864-8b8e-72a9-abad-0f9eeffcbdc3@molgen.mpg.de>
Date:   Wed, 12 Apr 2023 15:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook
 B1502CBA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     Lorenzo Grasso <lore982@yahoo.com>, Tamim Khan <tamim@fusetak.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230411183144.6932-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230411183144.6932-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Just for the record, I am adding the Tested-by line. Lorenzo tried to 
send it themselves, but even text/plain were rejected by LKML as they 
are using Yahoo Mail.

     linux-kernel@vger.kernel.org>: host 23.128.96.18[23.128.96.18] 
said: 553 5.7.1
         Hello [23.128.96.19], for your MAIL FROM address 
<lore982@yahoo.com> policy
         analysis reported: Your address is not liked source for email 
(in reply to
         MAIL FROM command)

Am 11.04.23 um 20:31 schrieb Paul Menzel:
> Like the ASUS ExpertBook B2502CBA and various ASUS Vivobook laptops, the
> ASUS ExpertBook B1502CBA has an ACPI DSDT table that describes IRQ 1 as
> ActiveLow while the kernel overrides it to Edge_High.
> 
>      $ sudo dmesg | grep DMI
>      DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CBA_B1502CBA/B1502CBA, BIOS B1502CBA.300 01/18/2023
>      $ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
>                      IRQ (Level, ActiveLow, Exclusive, )
>                          {1}
> 
> This prevents the keyboard from working. To fix this issue, add this laptop
> to the skip_override_table so that the kernel does not override IRQ 1.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
> Cc: lore982@yahoo.com
> Cc: Tamim Khan <tamim@fusetak.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Tested-by: Lorenzo Grasso <lore982@yahoo.com>

[…]


Kind regards,

Paul
