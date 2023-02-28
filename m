Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B096A5EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjB1Sjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1Sje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:39:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06CFBDC7;
        Tue, 28 Feb 2023 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677609557; i=deller@gmx.de;
        bh=DtFxm0e8Z7VF1ewH1Ljpw+R4WIItkXIaof9L5puDsAs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R3QsjA7OGtTQYeS9wl3oOXsylwtm/n6JHgbAyIDLSQ7/BtZgqpmDP5lN1Fdcv2wAq
         WuJJsV522M6WcMBYNfd9OmH0KrwgsCQVl9w47tPCXhArXEqV6zMHeBaN3SUVLKZ2Xz
         pOCguLbsYiy522ururdZq5B7EDtUgidu/PmOfL8Qg8hVlO1J5Ce5T45N78bhS6Mydm
         uP+IE09E88gpS3iqWAB4SC4oUz4qFXaVADHybhIbziAyhjfxJ3Ro8IxjYzmdef5yQS
         a7hfuz6HXk42zAVLRwRvekYEb3J418s3NGOb8oQ/s1E3FEkC3doH7rZF4uu5cGbUjc
         DVvYi4H5GQ2jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1orQXF2oSO-00fydD; Tue, 28
 Feb 2023 19:39:17 +0100
Message-ID: <ae6a9ed0-bf62-9a32-310d-286119ffb9e2@gmx.de>
Date:   Tue, 28 Feb 2023 19:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] input/misc: hp_sdc_rtc: mark an unused function as
 __maybe_unused
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-m68k@lists.linux-m68k.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
References: <20230209010125.23690-1-rdunlap@infradead.org>
 <CAMuHMdXWLAbXFUHg+TT45AqVq6kHxK=FN=5wEHnpdiR0dn2L_g@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMuHMdXWLAbXFUHg+TT45AqVq6kHxK=FN=5wEHnpdiR0dn2L_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YPUa2tSq33RwVxYoUl1Og8gJjlzv+5Pq307UknXdNF9GZXxz/wG
 O7hZHPiRUgUyAiIjP1zGJ9Rc2K8v4axpmHTV2Lyjacl+tu6fFwO4ax8QYBomsrjF1yYiCwe
 sgJmF0Pv7gG/Tob5Gw87oRL3bmssx5AHntnMYA8h/obcw+OHM//j28M3uXihwoxMLa4bYeh
 zsfSf7eXslMV4uEyHEQbQ==
UI-OutboundReport: notjunk:1;M01:P0:Vsl/N89OQdI=;qzEhaOtysIsq/QzRGMbknE1N4Bk
 uRZMQ7Jsa0cMQI4QTxl/SFOcGOpQIh2wJUPEZq/Mf70Oj5olhyKyltInx88KlbVSPMYsudk4L
 rNQJDKk0CTr1N9IxsA1CZjaUT0IJ7P4PLharuQT4OXWiY8sAD35VGaHQzFPVx/2PPl4C6dBrn
 cLjPLydKc/3Ps+GYMhHbXOr4XKGTj0j7ChwxPWtErbMpNgjW7ff1+TMzoU88JxouVj2DNOBn8
 4pH65yyg2nKKPJilbmMVpDHvBZDExE7ws9UVWwY5SoUTnD0Cr1cj3GfFxrNsoAyzREDgnE0Wb
 2CEKxkkFj2A+KgsRcMusQRc/u8tFJFSN7EIum18aMw+m74F2vMRVs22yV676q4+3S+8ZyO4AS
 hcV/Sc2Z/0jHLCLQJNl6uVJny+bt1tmBwnGYPCSh7jFaMuY9BKNSYg0M1O7wiXFkGYuKpysGI
 GIUJWGhAiw/YXjild8low0+m13YNPRmETmKpu3YLpGaJyDySbWXtYqfJCf+ZPFo0SGQWiVR/z
 aVJ6lEsk0ez74SyPCRmYEU+gqbxGh3NdafdPtXA3AchB1AQMvjb+5l96TZyaFvamZ4HvKJCPQ
 tuYySLdOFKuv8/t02bM9nnpIJ5Od2BBzIIBpV4oXNwcIGBCuiq50asfBJzEnOdy5bRbxJ2Hzd
 dXgqp6S2U+1P8+Ikva5ukGl84hdjp8fd9kxAw2YVfhKYmARiM7GAmJFwovypr2gAkm+QRo2ZT
 YE0FJQvvlhgeUJp0UgnkB7oeytH4ricD/zB/pDkJj6BQfkji77g/jkuk5VMFjIFFtiy7BlQLx
 tTxxxNvsl93lJfNxCaZlnHfKm8w00C/Dqn7Gg5myH1IddkM1egNRuwSsok4ZOgk8ugd6fUaC0
 7TXqn6DegTluaMbqUMdgexV+cA3iUPHrOCZF82WClIgweid4V91Ntj7MpJuEXLmwwf7R5njDq
 1axp0L6c9YjtSy37/ZPc5WmclxU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 14:56, Geert Uytterhoeven wrote:
> On Thu, Feb 9, 2023 at 2:04 AM Randy Dunlap <rdunlap@infradead.org> wrot=
e:
>> When CONFIG_PROC_FS is not set, one procfs-related function is not
>> used, causing a build error or warning.
>> Mark this function as __maybe_unused to quieten the build.
>>
>> ../drivers/input/misc/hp_sdc_rtc.c:268:12: warning: 'hp_sdc_rtc_proc_sh=
ow' defined but not used [-Wunused-function]
>>    268 | static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
>>        |            ^~~~~~~~~~~~~~~~~~~~
>>
>> Fixes: c18bd9a1ff47 ("hp_sdc_rtc: Don't use create_proc_read_entry()")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

applied to parisc tree.

Thanks,
Helge

