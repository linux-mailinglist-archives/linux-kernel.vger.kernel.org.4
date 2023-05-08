Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F86FAC7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjEHLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjEHLYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:24:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5233A5F7;
        Mon,  8 May 2023 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683545077; i=rwarsow@gmx.de;
        bh=eGpu6T41uKBUAdNXsHogIHMc7zYQpmcAcSh7prC0PSY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=flRPGvrmaYeIH9fEFtIqZ+h8e0jXx/vokZEsXdHRzulUuV7qeXuP+w3YlpYZ/RWPg
         IszukVFATi2ZIewDdF69lyEAoTLPR9wUTyuyaNm7yJ0JGbkH/DtsN8HGgudwr6A4PI
         OcbVjkqBgxZS+g4q8CN5u7zdJ0I8SUTIbs9eEaBDWREDcIJEpMJln3bXc7aRh02tGZ
         bdZ1b9wcH+z9QYPBVJPhvVObbb0mTGT5yUKXapFbHr2henJAjajzMWlyDmi3NDxD6z
         jTc7ZIiz7H0aGgtWQKUDEqJGWVk2RuqN4OdOm8TwFP4UJ2oxUgvi2aRG3db0MOwLD6
         RBaLS8Gcl3LyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1paifP3U83-00Mr3X; Mon, 08
 May 2023 13:24:36 +0200
Message-ID: <18fbcc92-cf4a-d8cf-633d-2cfaf1572391@gmx.de>
Date:   Mon, 8 May 2023 13:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ej8BuxwKPHlcfg5gL7MaH857ao09IgNI6m1Wq1Tac6/zVDNZeWk
 YxBsxElPhk3Jp2rnpBTlO8ZbtNg472WO4mRPQp1i1QZigPBmywVgQ56SsCtwDBbMh8jcLnE
 wLHvlNAuFKYZhmZB9FJ8wbiiiGazNF3nc7EhtUycEZ+urx86BIfRgy+jBZILMuh873Tkh1M
 VYbrtDSGwfBuYAQY3lZNg==
UI-OutboundReport: notjunk:1;M01:P0:QrU2GusboR8=;ld7vvQX2d9xQRytE7BzscE2woIt
 NvrCmySg6+uZycUpZTALIwD2hEqcEOWHkyQp13B8MSt8ulnPQY1zOM6rYvJFBlwgfSMZUObSi
 M+c6CxVOY7IHFytipjGBtMlxkq+iwNeoyXmbyDEpL4xklzB+Sm98vmA/R2Bn6Z5RTe/Gzc6Az
 ZMPkPnai9AVDKve2biMHddiOemIUps5cE7m+NVThGK4T55PRNF9+I+9MHehf81FS3MqtD/QIu
 lxHpPI38TLDh5uHU9oNKoHTjbaTYNtpNm0sNp/7SK2SUryYlwzmwwOokgoBDFg7imFJqjiRZi
 IVtO76hNBkToNFAsDyKdmppENwxNt8m1xGH+wcsaXQWFgYnfcsxpPpaTT8YdC43yZjRF4GcDI
 iwdqhCdb8Xfun80+JLyqa3G+HIulhO4XE+Dm6SpEWrO1RZhCjn6rv/ueS8f+/p91s+HAX6DEV
 3lQSMHGWWTH+vaS1MnzDaAzitvkhhoqEejHYzaVcRqN3rhfpgOu5nwJZAFD2YPCUe0Zg0Nbfq
 /CXyHhKMnH3KbIe1zAjRzn7aRqzbxJJi1OumMZ2CLF8T6WkfWovzHAsqPiP+8Kb172B5PiIdP
 SOr52PspCzmXXbXp7ek4+3uGb1laIE7xPavsrTDOX/aH4eXh0xMD+ZZde2U4QpZ1Er8pW51tV
 kpfOzSF6LLYFnLpFAwoZN9/6PlVfvAISigcY2FMx3/nGqHzxWK1cpsPsQAXti+jaKnNRB7WZE
 JTS3MiE1US0bNLfk8NWQmPnOOZfGLHOjnF7T/VaNZfa8mgUgp/Uw/jh+BrrLtpp9+Dibwz5NU
 7ut24oOvIqGfoTEuca/r8GRc+jDHDU8fgjNq9rQ+cYtWbjyyIrwSO+EoM/YHXi+ogceXnrpf6
 Wak0MjQvOfjeCmbs1A0Jzat86ctjfM/G2aeO7y4v7ndzBhrc2+iPDMyoFPR5KNukqm8LM5kzt
 72WuRLjYmcFKHrGgbJqndtByj4o=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.2-rc1

compiles, boots and runs here on x86_64
(Intel i5-11400, Fedora 38)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

