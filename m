Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683D632BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKUSNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKUSNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:13:34 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A296148750
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EGCjxibfGRGWcHEcF05lQ7fpC6xBYzkRntZKzSQejyo=; b=k6wd1BkNuQu5gDCU/YOmA55BKW
        8cEAGeYDEt/U+XNCmqGg3S+z431UMU3rb0Zr371Ffn5nLG/nWcNenBHGnY2ZK+wiWEi9nRzMrFEbM
        U47XlSiQMyVqpEsBvqoDXer2dRJkLu4aVd7d0GqY80WMa6qADTD2M+yedntl5s6LoyCNOyNfgd/lG
        7Fq/9IFym4BthrWsiIfdg7cNdSTnWpfOdson5OfGkOrtXMw67ZsdrFf+9lVIRvS1woT72SCoqFLNT
        Ra9oGVD4gHNgWEa4XHUBBEESKsJOuHREZqURdM15iIJ4u/O0sPmy7oq6iNMYDiyAfypUQaZ7HFkB9
        Qq5QQ/Cg==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=50424)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oxBIR-00062M-4R; Mon, 21 Nov 2022 19:13:31 +0100
Message-ID: <de12952f-8346-8995-236d-69dcb70f19f6@tronnes.org>
Date:   Mon, 21 Nov 2022 19:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: git send-email friendly smtp provider anyone?
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
 <20221121151922.jaal6ym7z2ejju4q@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221121151922.jaal6ym7z2ejju4q@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 21.11.2022 16.19, skrev Maxime Ripard:
> On Mon, Nov 21, 2022 at 12:48:52PM +0100, Noralf Trønnes wrote:
>> A couple of years ago my email provider blocked me from using git
>> send-email with their smtp server. So I switched to the one my ISP
>> provides. Now my ISP have outsourced their email service so the first 3
>> emails gets through and the rest looks like it ends up in a tar pit or
>> something, 18 hours later and 5 of 7 emails have gotten through. I have
>> asked them about this, but I fear the answer will be this is not
>> supported since they now don't have the service in-house anymore. I'm
>> waiting for a reply.
>>
>> Today I tried sendinblue.com since they have a free plan, but they
>> insert <br> in the emails so that didn't work out. They also have some
>> kind of queue, after 1 hour 6 of 7 emails have gotten through.
>>
>> Does anyone have an smtp provider to recommend that works with git
>> send-email and that sends out all the emails at once?
> 
> I'm using fastmail and am very happy about it so far.
> 
> Otherwise, you might consider using:
> https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-with-the-web-submission-endpoint
> 

That's an interesting option. I did briefly look at b4 a few months back
but it looked like it was under heavy development so I figured I'd wait
before trying it out. I think I'll give b4 a spin to see how it works, I
wonder how it handles patch changelogs.

Noralf.
