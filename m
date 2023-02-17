Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957769ABD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBQMsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBQMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:47:58 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29343CDE5;
        Fri, 17 Feb 2023 04:47:54 -0800 (PST)
Received: from [192.168.1.155] ([95.114.119.171]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mtf7H-1oY9Mk3BJX-00v8d7; Fri, 17 Feb 2023 13:47:21 +0100
Message-ID: <cb8bfaed-e36c-1667-3dc2-af1c8adb7e9c@metux.net>
Date:   Fri, 17 Feb 2023 13:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/2] Expand APU2 driver to 3/4/5/6 models
Content-Language: tl
To:     Philip Prindeville <philipp@redfish-solutions.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-x86_64@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Ed Wildgoose <lists@wildgooses.com>,
        Andres Salomon <dilinger@queued.net>,
        Andreas Eberlein <foodeas@aeberlein.de>,
        Paul Spooren <paul@spooren.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <20230113231139.436943-1-philipp@redfish-solutions.com>
 <44e0ef20-d6d3-4c87-1828-f88dbc08e942@redhat.com>
 <343F820D-69E1-4120-89DA-980FC78E3656@redfish-solutions.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <343F820D-69E1-4120-89DA-980FC78E3656@redfish-solutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fdK7UsuUh7kESZ1a7OnEiEsK/kQxBiZvCvdGxzt3jb0YWZsbIln
 NFSdAAtJJ2qaXFHtXJxtygK13zeEPdS5Y1r2H3GdvJIcKxIjHyKWeaRUeh931TSmqGjci7m
 yhoQC7rwZW+tHQapLgaXpq4HIBhgUx3ABB2MQbSi5s5pdxuCWz+sz9oKb+ByMO0JXqshdWH
 OoU/FwTmqaqwzY/6wKg0A==
UI-OutboundReport: notjunk:1;M01:P0:3loR27yf+Nk=;qUy5tvX07J+vhlsS/6Vj0TY+bUE
 71i76cKpIRPMcyA9Wq0GitMAz1PAVvEPqWO6FO4Sm/2q9ARf7ooP2u6JEQ9WyQAEqeVD59X5m
 rtsurxZD6GTr/BvKaBii8du6dfo4WS6tvba8iNbRzTUqCnUEPE01EAfP+EVD0mOjAUhexvWiV
 6xU4XM0J635Ku8gJ0XgpqGNtTZVvWgI+GFFqr0hdR5EXudoiJPUqJFnbqTPwQiRvY/fDIITx9
 AYU0uBKxomitD/D5bof1Ea3PLtk01/3yafOOnbKAcBKXDHG2Ech2wXq27YYsMdl7r/HrftosJ
 t87VwgoIIclV+zjO0anDCAd9vAVMUXTqgK3WC8Vv5qdo4CRvXvso1K/uzngKdMy6uGaQlOA7r
 b3yaYG81RQJfq3VqkqLW8JapQn77rHrLgulND2mh/OxW5UGKWlR5uLdwtmi1fRrDQ2AshYju+
 jqjdRIBZ5te1QUyf7RUfcBWQ2fLTEUoSyCm7h14rWD1xT2d0oF/2/223/omzPtto8l0OUc/ZP
 255c5zosQZnCkIUiUipuy5M8Ptx5kUpQ2XAhyfxE6Z9drZWPuiTdYintzKhhJ9+IKCb9sLzbd
 fG2FCk7382QN5mfZtmVKDez9PuCLwyY4S7l1hugV+Um/mItT0kKRUqcU+MoGmY4FVVX1d5hpP
 BdFF1Csguu66fRM1mIm4NQWIq4P5P0f8I6u48zFrMg==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.23 08:17, Philip Prindeville wrote:
> 
> I tried to copy Enrico on earlier revisions of this patch but they bounced so I stopped including him.

Which address did you try ?
Do happen to still have that error mail around ?

Recently I had the opposite problem while trying to reach the xfwm
maintainer: Google blocked my domain, because my provider hasn't
set up spf yet. We should circumvent those abusive corps anyways ...


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
