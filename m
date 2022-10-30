Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04CD612BA8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 17:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJ3QnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3QnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 12:43:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52254F1A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 09:43:12 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pBOwoZYqRGYmzpBOwoclGr; Sun, 30 Oct 2022 17:43:10 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Oct 2022 17:43:10 +0100
X-ME-IP: 86.243.100.34
Message-ID: <c0112b1d-e3bb-9f54-eb0d-f5d77275a323@wanadoo.fr>
Date:   Sun, 30 Oct 2022 17:43:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 debug_check_no_obj_freed
To:     Wei Chen <harperchen1110@gmail.com>, linux-kernel@vger.kernel.org
References: <CAO4mrffA2tTwCKQ-objUH7BJ2GjSXaJdi=pq0vtqjicx8eH7wA@mail.gmail.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAO4mrffA2tTwCKQ-objUH7BJ2GjSXaJdi=pq0vtqjicx8eH7wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/10/2022 à 10:23, Wei Chen a écrit :
> Dear Linux Developer,
> 
> Recently when using our tool to fuzz kernel, the following crash was triggered:
> 
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5

Hi,

any reason to run your fuzzer on 5.15-rc5?

We are at 5.15.76 and many things have already been fixed in the 5.15 
branch.

5.15 is also old.

CJ
