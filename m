Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C15B75DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiIMP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiIMP4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:56:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221190804;
        Tue, 13 Sep 2022 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663080893;
        bh=U0tula8yRud0hiUX24/mkl4hRNvGNNA+ZwYJr5fT4uo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MAd1HedjtbTbGo4XZRk0DIoCM4CkyuXs6fFN+HlxygkaW0oQuJRGBAnaKKSiYqrTr
         ypeTt9vpJ/C7KmZ/UY+ugCu+EvBsRVdy8FKF74IAW31xWzeUVtybM9hXq+pnSPlWeA
         UU/N6jO+y++F++Jc0tSUCznqs2JVTIV6sTtxz3XM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1ohI8k2p2f-00QiCV; Tue, 13
 Sep 2022 16:40:47 +0200
Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
To:     Randy Dunlap <rdunlap@infradead.org>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-6-W_Armin@gmx.de>
 <b1b794b4-f6c3-7697-5d5a-b811809a9313@infradead.org>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <2aae0ae9-9608-675a-ec0c-6e7526e57363@gmx.de>
Date:   Tue, 13 Sep 2022 16:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b1b794b4-f6c3-7697-5d5a-b811809a9313@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:U/bnJaxu8PFOXaOsXf6noN79WqSKTJkiOModm0klG0aSDhc4FUo
 GJf3IVNAboRMzsoyBd4IGTVc2ULCXZk6hxYtTLhbEnnlsyCViVxuRM8xWIiQYENgqkXjEHg
 ZmCr/+ugGjxOAQIpvuuilIMw5v5juB8mhodbk4X4MtZgdhopFvNPk81f2JucDHTZ0H4bwfx
 O/uZ6ytPV4a7T/4eLb3vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v1hu79n6g3A=:7hxnlMm5oBFokuwPlaFOI3
 xlf6+Ktocvwi4l2bH9pNmOUtVQqc2zBiX7lfihetRnDVA8XK5lgwOivm/FITSnUImCgq8sbEe
 qas7RBErSavvKSjppwMM+RsEGu7jV3UbaLUhLth1BvudPWzmi+VGCb6h+LjmM0bh/DP0ePN42
 FbQ5nHvlNASKELMy/5i00mFlidNTqv5KvoTW7oF9TW1Nzod4YNJuwxnuHY/UZ0MMmUTbw0BCN
 y6w+DGxGM/7386CGyBUrTRWVQwEYZwrH/kWgQpmjVBGGPB2cHqWd2hggQjGXouu0IeBj0FZ/9
 FQ1Zz17yajmPmIoSD2dE804FLHHQCJ52R6k3sMd0w3v9gC+4ZY2gVQTWXpsa5EAXmDhjBYomC
 6nKh3Brt6gCaL7B8nkPfDtZOBSBBUGgrUCta60AfmQjVNDLgeekIVlVClnpKEsrlg91lL6BcV
 PHHWbTr78hkhT7ih1J7K2fJVANxLXbF3CbrGf0wUjmo9vspmdN6SWCzNG02NGP/D6a0YiHtJu
 yKemQcJjtKKH+aNxjxUkIDHeeBpFp/RU2BhSsRuSffRWF4W+rswOcVNNF40KCMthEdKak35J8
 nMNKcgvpuxclXENQ2DcW8G5MC6VaPTAaMWCBcB9B9jniS7VzP8Coo7KQWeN+Ae+WtD66grY/F
 0ROIu6GTf0sgyGncxclpltHWJFqYtuPHRcF56sq082U5c9TIlNI7U4/SW0UNeTfMk/NZRCV1+
 ciGubgzW876lnAIGOmoJzbX3F+a9KoJb13RsgsblbR3kBQlcDFqvmAPczS/Hzgky/rfKUDXhd
 gglbhhjPMRtbtfSWd/NYsUyp7I0fPYiHc2NCoCIKrYxKWigG7d5L7/5yGXkLVnmzpot4kqzL1
 drP2tPQDdwLMbSdoyjybtRTKmOkFS0n0GJE5n7YKoHfqyIrv6870ZjUK8jCVPrU6JwLhtegpy
 Wl/5uc6vsFv2PTY5DzG+/THQfGMTiY6IezF1jYpnYFCLKeingmlXywNfmtnos10w1m9LNDErl
 LFosOzxV0gmLExeq/oSQjoVnSqoZOdnFrhLexuNiP5pfYyxxWloIsd4cip/e7TXsOe/N63fWP
 +I1CzWKwLsY4SocI+fRVFSiQu85Mkg6lWkoDk9Se1im56HJiu/F+lZexqkvaLnWoC3gWoBm31
 RisjLgWlRJu0djdqgy39mMCDm/
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.09.22 um 23:56 schrieb Randy Dunlap:

> Hi--
>
> On 9/12/22 05:53, Armin Wolf wrote:
>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
>> index 25421e061c47..209e63e347e2 100644
>> --- a/drivers/platform/x86/dell/Kconfig
>> +++ b/drivers/platform/x86/dell/Kconfig
>> @@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
>>   	default n
>>   	depends on ACPI_WMI
>>
>> +config DELL_WMI_DDV
>> +	tristate "Dell WMI sensors Support"
>> +	default m
> You should (try to) justify default m, otherwise just
> don't have a default for it.

I have chosen default m since many other Dell platform drivers are being
default m. Since this driver is not essential for normal operation,
i will drop default m then.

Armin Wolf

>> +	depends on ACPI_BATTERY
>> +	depends on ACPI_WMI
>> +	help
>> +	  This option adds support for WMI-based sensors like
>> +	  battery temperature sensors found on some Dell notebooks.
>> +	  It also supports reading of the batteries ePPID.
>> +
>> +	  To compile this drivers as a module, choose M here: the module will
>> +	  be called dell-wmi-ddv.
