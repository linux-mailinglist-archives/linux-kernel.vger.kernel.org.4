Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13A6EF53D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjDZNNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbjDZNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:13:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054E5249;
        Wed, 26 Apr 2023 06:13:18 -0700 (PDT)
Received: from [192.168.1.43] ([77.7.2.190]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRTEr-1pfNGk22kv-00NUKv; Wed, 26 Apr 2023 15:13:11 +0200
Message-ID: <57ec90ad-8535-fa7d-d6de-d5c1d06f37d3@metux.net>
Date:   Wed, 26 Apr 2023 15:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: tl
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <20230426003210.GA31260@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/kp+teJsXj+zPsDbO/9jXV2pl8nqJSfn/Z12XaWIEPvIyFVudpS
 gvzy45liUJTCf2eIGjnnywTj9r2s5ApDWAJf4eiaZ923tjL6+CgtUAePz0khAi1ywDwMo/J
 lIG0rlfgenFsP8nTfG17Qcwl9/0T+5PeIbR+1xGbZHIrcLxU4LKNZ8bg+0rWw+W1rAsprtk
 QJluCXN6MCcGuU2KgwQXQ==
UI-OutboundReport: notjunk:1;M01:P0:K6b8CjFnLDg=;QAgpZbiirFir1BJsZeaUI6ymJ4E
 AoLTvBx4ecHRztxqK8XhY5Ae5npKq8eVTiRdW5lrHHrpUegiSSDZMEEQDp3mzR76+8v6fCcdY
 TgT93IR77qwbUDLWOm07C5KU1MJE5gBOulJYjrRvUe+CFgCRW0LKJWhclCZMEeYHBeaq6ntpP
 MMMDoVW1qnjd2iCFwXWk+Paj7Ko2ZEg6YZWi/EepaFX0ypd0G5Hrsjs849nbU0TsLj/gfC60q
 ijUP3/v9C/Kh2aXYnlZJh+DCb3UJgiM1v2U8ZCzHX/KaaPTTgVrdooVyzsloR814k0bcMGJrk
 RBeHFFMxgLkXnyqbsbSwiXn7SGmHLUOqxAUgl47orbQgHZz5J9K0ZGXncDCb9JEvzeR+EEuhi
 mD2Gd4Dte+k+mGiOqH22OPgW8ASrpqJgy8VrprHeNF59c7jAIevuYelbIfd4dk81t+fTA8ZMX
 i/5GEYJVWzvk0AQJv/W6yd8ZfipGbsLDrlA5LwJm/PEaDuT8PT+V0WCOCbJiWqrg2ra5H5jdL
 HsSArSP1Q2ZGftwH0qJu1Z7WgYzchrr5nNlVnx/LjJA4KkkiDRpqSWxN3RbkbXOmsW2TgULjm
 w8N3H7yFw7lsaypSA/mZ2H/9jc5XLGG9QW0FY3kvW/XchTii+dSs12yPB4CK2dcpLf1u9LlGF
 Yh+Fw9oOe3QfO2/9oEpEWlkeNoLd3rzDxovvnQGRNQ==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.23 02:32, Laurent Pinchart wrote:

> We have homework to do when it comes to maintenance for the media
> subsystem, we're doing *really* badly at the moment regarding community
> management and attracting (and retaining) new core contributors. 

Is this a problem of the subsys (core) itself or individual drivers ?


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
