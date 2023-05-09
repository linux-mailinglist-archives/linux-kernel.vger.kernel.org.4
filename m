Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8F6FC3CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjEIKX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjEIKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:23:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4EAD864;
        Tue,  9 May 2023 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683627822; i=rwarsow@gmx.de;
        bh=tbUnTBrhsp3v5Irmv6by48/eeQJh3MU77lTkBqaNiaY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=NmEtyGzDJqL34QNybHgqRiQShlJQ+djAbeaL9ESu+x2sbkipNf1CbDITDth7blJhY
         A4pP3E0xtmc0YMiJVJuIU6I6xAIiYg3mPqC+80ZI2JtUIaMa0BHApa0RGuO12TCtZO
         L/5qb5lB95S31M53yZoEJisrlIVzjq5+IIwZm/UDVgj0NqcWCQk1WSDZKyRdk5ir83
         sEzMVTGfWk7nA48q3WhtAWfw9F11ph70DngM158hsICubDSeH+/mh+29aziaFzmp51
         K9gizAtY44xRn/Ub9LGtnCMkb8xfHuLsjAjmS4eR7ZyL4ri49MokEL+G9+D3o23aeO
         xcy+9UgeMpxYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1pruf80hQO-004Vjc; Tue, 09
 May 2023 12:23:42 +0200
Message-ID: <8cbd0379-2059-7fb7-488f-5858d661a8bb@gmx.de>
Date:   Tue, 9 May 2023 12:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bV6Z2QHQnonO+lUDM2kVejnW0u3+D7gDbhbUeBJZBvEow0kE1Kf
 /A40Y9EYtkTxEpPWTBil5NxEJt86qxwHupz5ZAHYihpBqWX6hylCMWdqmvVCzELfVFNuBot
 eVEhQ4kuREoDWxj+sfZ85VdZG3wDmUkJcWVSFBmxs/rbEfWTkT10h2pwxXTIpgrTg0h/aov
 nmrwGrALRVp6hwoJzd2vQ==
UI-OutboundReport: notjunk:1;M01:P0:Dbx+NSSREpI=;XUlZATIfDRphEhk01Tl8M/5xcnQ
 DXfSGXaUpeRbjQ3fcuPIzR0marAshoQqR07qVO/ZYIA3uMQ1aGoVW3XlIiL1l38I3dYbnRs1G
 PY/U800rLjzOZkUPw9NW2XpdmtaQDD47bAJpkBxT2x+ad4tlEKDLPrut9mtq0V+JRen5Ck/wC
 mrTkWNGrKDtOZN9W4b8ET/e/W4YnEntvLNSSLzUnBrfkG0Rucg5st1IecZa/sR/Cv10X/JZaF
 edSWJI77C7EwarepDCHdrVhl+niF6mfk3Djjc0xWpNYJpNPuwENhBC6I6ovXgsu5fzbjbkoUO
 KHqz1FDDKsS3hNQnUHcZdTW/MO2S+2pXjgDL96fJJK1HOvzA5LxotXs2/gwzvE4wxinWefkvU
 zh9CT1/sP6VNaz7o4DwMnXP6Xlhns48Bl8tjTAvSBUpZokO4xj3IzTngFwKftuFN65O5tTnyg
 9QDvGHWJjnbtPucy9pfssp+jWdwDP0Bz+RtiVqeeSgu8Z1YsieVWZi/Tp7DuXHnQi0mpdW6I8
 u+pkvFwSecGpG/YUlzkKfinfAcxAZCuL9GB/pRBdSdxXuLX71SCRBbMLeQ/wMIL5NSeAy9cjC
 oPcKjXvXdNV4zS7dMvBQxkS1Ek+rwkbv1pVtxg8rRxZkIZvvt7KcX1xaNCVUrG3WGup2jNXO3
 XhlbcHH2vdUDCmNa789JN3CeAkU/8I4WXmdue5oMmqiHtMwYVguqNyd7ZaiUZRAq7z2fxYU9u
 7dw403LA9p53+n5UYY6pjrgm/MYKM9PUnSFDRCwoloy4RzkRILZoTnYlihxi0o/51y8OX+OEs
 +FxbHxBJf2eFX3TNJKJhJtgatGrCFt4s48bjmNU+rTXUlxsMc3rE1skaXJfMYvFnhJTOlrCXu
 AbSvSeT01VYYGvvMPj9COaBdIDv5loljiTMt+Sw4poLb0+1eN1SdqbrT/XV76PQqp01rmnyF6
 ZV8HFBQmvBNFhIhIZ9xtThPIznQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.2-rc2

compiles, boots and runs here on x86_64
(Intel i5-11400, Fedora 38)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>
