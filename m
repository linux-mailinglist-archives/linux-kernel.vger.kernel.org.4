Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9076A2B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjBYRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:55:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7751284E;
        Sat, 25 Feb 2023 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677347718; i=deller@gmx.de;
        bh=UWr2w1/TKn0HiuzGMzpnxcufJtoJoLzVdfg6XeXTOXY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oUwIW9HbYtXHNpaq4ATuospNcULVau1Pt9T/DTAbDHSRPYPlIMdNt+h0qKsISwfxo
         vQp6i+9b+p1OV9JhUkUJ3mb9Dx+VF3eV23ggGFf+rWMRtFxmRMQtLGiydiZwaqST3H
         4PaLpBfOA5MHke40jxDl50nSjfxAGX0Qjn9syND2sR2cONrhkQlcPDxVGFJwykMK4D
         icJwNcNwem9TZ0hvZ4SlEIxWxDfvjcpZv770uLuyKxCMBW/9ris1rlgC1xKXMjILP2
         hqsE+fMQd0mFzAb+uVoGtFhDHHakVH2+D2/7yFrf4m4jTh7UHvSBchUETSeMeZF4s8
         9rHGHeoZjs3Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.139.251]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1obyMr3zzo-00wWJi; Sat, 25
 Feb 2023 18:55:18 +0100
Message-ID: <4ad0233a-01bf-cf4b-1e3a-0d1cacde2707@gmx.de>
Date:   Sat, 25 Feb 2023 18:55:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] drivers: video: logo: add SPDX comment, remove GPL
 notice in pnmtologo.c
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Romanyuk <ufh8945@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelvium@yahoo.com
References: <20230225071230.11494-1-ufh8945@gmail.com>
 <20230225071230.11494-2-ufh8945@gmail.com>
 <CAMuHMdUNn1Dxmfq+Y-B=CPDepFKZSxn=NTF2nG0BL=WBU-iG9g@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMuHMdUNn1Dxmfq+Y-B=CPDepFKZSxn=NTF2nG0BL=WBU-iG9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:htIov9ANEKpkLcOwSxeyZ+nvMloeJYSbBEYJca1k5l4VK8x113X
 2I5pmSxbBM5H1d8hWW12RWkoSZ32oMW5GiXwO/i6v2iIJdCEXEv+jbA6H2YSg5V/nmcNTPi
 J29m3I4bo6lfaX/WRMQMDSjTrYAxePYqdUWY3l9vnWS8NLL8vmsrImt9YQw8DaQAAHCSYij
 1V/jfYYQ/Cw2JnDyFx0lg==
UI-OutboundReport: notjunk:1;M01:P0:vAL9zFLoQVA=;kVdn+PYJedox6uLhlk4OGWF4QVP
 Up2ZXsgHXmddbR8UmLG/JZSfMP/9qiPMleXGoIfMcaabbdN0LfCtOqHTF6REU29BrWHhTG7w9
 4E2NgZCWapNcQLlFLzqO9kW7VK/2pq6S9evbZ1Xlu2CiHmjn2H+uXJm0ZWG5qlnZgClaKzyYn
 I9JQ445jrn0VYVyewdydEZq/vZERdn5ytI3CC/VXxMTP2PkkRAMVhGv9u7Q09Dhktd8ocdCzs
 YTGegBGRtMkHbF1fyKNG2V1C5mmMO8qg1I47UsUE0yroI/WdF0rfV8+IeyXQHXaZOIM0ij1lO
 jXtZfZtVMJL4H1gkYES/i3M9HmNFTkIhLY1eHdPgxPfu1ezdP5xYf2Nr+pYE6XFDZNw8vpTEK
 x6PN12knVpWDOCHlFFZ0l1DFaHoDdfjbJe/1X9BozpgBGMXsKUI9WgyROyOJz8MPkapQCU5FI
 6HSSZqSVoTKtHoeN1sBhY3tTuLWXqBAvXJ3O5pAKMnPrJky5ymYdhccE3tsbUgb02QcIo2MSi
 /t1q4C10amb4G5P9/YmdqUXO8Ooo6RgjeQAFIhAA3UVDYr58aTSbM9OBWr/7KZJmPgwykQNHM
 HTwAIiMCrAmsdO6XpuJ8moXTnXzZgBheS5dRXAPPeOltvvGnv9OEThmggBvUj5+LS1saxanm1
 kbqPzKnEpFSP8Oe+g1r3vWohRcGnmG5n0HMO3VhKv7hArVI3dYddfbRB+Vvw7g7nktpB6ADA5
 WrpJUkWjo/Mxzlc/F7Ofsb1fvuAuVVY6ataHTDkDOvglJIjrtcYLU/GxpT9VYyoI7bh/SaTPJ
 K1oUMTr13w0e7UjXfpzhgBk3HHPTmThctyuA0e1SsIpBQCXaZ4Huif3o0Ckie7CB5D/WB0xYD
 MIam7Nq57P7T89ZnEdW23ZWM8jF/wgqSSsiBshBJHCcvXi14Ii6dq+zNIToAOYVEkpAQZ3XMz
 uoO/sdS3rm1HUIXpluLrE/qIOlA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/23 14:51, Geert Uytterhoeven wrote:
> On Sat, Feb 25, 2023 at 8:31 AM Nikita Romanyuk <ufh8945@gmail.com> wrot=
e:
>> Signed-off-by: Nikita Romanyuk <ufh8945@gmail.com>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Both patches applied.

Thanks!
Helge

