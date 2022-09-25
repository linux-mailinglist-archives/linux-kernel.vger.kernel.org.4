Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8E5E94D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiIYR0T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Sep 2022 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:26:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5772ED57;
        Sun, 25 Sep 2022 10:26:15 -0700 (PDT)
Received: from [192.168.0.74] ([91.64.235.177]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MelWf-1pCw4a1yZZ-00ai6H; Sun, 25 Sep 2022 19:26:09 +0200
From:   "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re[2]: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
 V0.96 controller
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 25 Sep 2022 17:26:09 +0000
Message-Id: <em400277f1-59be-4244-a317-965b09e2e96d@b1aa21fb.com>
In-Reply-To: <YzAuuvSBPohXMCc0@kroah.com>
References: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
 <Yy7ENBX2Zo3vNgB1@kroah.com>
 <em98cdb3f1-82c0-4fd3-92af-9c3d062b3d0c@35bdcead.com>
 <YzAMRPjywl0f4uSY@kroah.com>
 <emf600f901-91ef-4aea-931e-9f6fc5f42c86@689b6561.com>
 <YzAoUyw1opYHVFGB@kroah.com>
 <em9fc0c9e0-e371-41cf-9065-1b007b937158@689b6561.com>
 <YzAuuvSBPohXMCc0@kroah.com>
Reply-To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
User-Agent: eM_Client/9.1.2109.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 220925-2, 25.9.2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:ZEFfcEFSTLY6Y5cEbHFnd9shtPGfRj//L6LV3lb7A77XejTuNta
 7rL65U6JZ+V3Goyz1GLGOOPVP/jvZawvK/SWUkFMW1ooLsQz6ZRrD+AYBxz1qBOaIj77Ddq
 Vc9MR5TkvvwHnoD6oNjTxFqw6R6Qo44u82vrUCY61mad09EvLVXXjLWpaJSiQfELg2xSUz0
 RHdW538IehpF5EmW8I+xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jyc/MC7Scj4=:teRWFFbcRqI+CuF1eXoyY5
 hhFcuafek0it0kXgVpSXR36vuqiDbjiYfOWUVMGcnwst18K6jilDstfBzV+UAye2mCn9e9OTG
 muqADZgQV1Zi7gxZecfd87qQCmxkNxgZVxQnJFJM41lSL1oP2Nl5eLzFl04aueKY1iGulw0oo
 97D8hVtujtXpE1kROg1k/94WT/iVsGmwjdXmdrtY9s6iZlf2s2Gg0oW/Jox1d3kuE4kJ8pDAU
 3YaHDHXCFzvUUb+Gn2kkA6MKF9vzLYqfi/CFnlJ19rPNdiMewGCkytl8vimDvsLeB43btwDlE
 86f+GLl2oz+Fmz6i4BMSt01ZczNj7hnIHYOaOTmiy7ONMC4AMW7gWYvpgQLxp8+ugBJeW04dD
 8bE4sP6aghL5uL1PwgORozHS2cDhjwmVQh1V87qHP7sHPsto5KYTS3j5uiP886WiouT8JwDoz
 2TgymtwuPURRY7puQfroUo9upa2uY7U12ZkZv758mWCp6oMudoEjtXo/ctnFytwlSHyvQ3W/u
 zzlwKFoxZUmKy0pMHp8q3nXLa0IDQVVc+1C1Wk1LHh0vYkDfW1CPvES+CSiulny+V0LryaHUL
 zrHb2TW/HArkFdmp1+nEE27bFSlSAH2tMi6lhVv2nwwk2UAImoOHeRI1/nh3rpOfa67cNo43m
 P5BEbSBMJJ50OMy9LJ+0JXy/maS0BieJ9zcJDOoswWoCDa36OS3DlmEi2u17j+diNsQHWS6fY
 xt1M+tOzeH7643nmkwd8GbGPJbJD5MovObspVGQHAQ6wVu73WbxwV+SuY2qklMs1mPlKqSdtm
 XPKyw277360x3uDnqx2Yh7yRIQFHA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

thank you for the hint. Got it working on vpenguin with removing 
sendmail :) https://git-send-email.io/ is great.

with best regards

Jens Glathe

------ Originalnachricht ------
Von "Greg KH" <gregkh@linuxfoundation.org>
An "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
Cc mathias.nyman@intel.com; linux-usb@vger.kernel.org; 
linux-kernel@vger.kernel.org
Datum 25.09.2022 12:34:34
Betreff Re: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite 
being a V0.96 controller

>On Sun, Sep 25, 2022 at 10:21:39AM +0000, Jens Glathe wrote:
>>... and this is the moment where I append the patch file in hope that this
>>somehow works.
>
>I can't take attachments, sorry.  Try using 'git send-email' to get this
>to work properly.  This guide might help you out with that:
>https://git-send-email.io/
>
>Also look at your subject line and try to match it up with how other
>commits for this driver/file are done, it needs to be tweaked a bit.
>
>thanks,
>
>greg k-h
