Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB1679C05
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjAXOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjAXOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:35:02 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392333AAA;
        Tue, 24 Jan 2023 06:34:55 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so13167526qtv.5;
        Tue, 24 Jan 2023 06:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBgdeB7eNpLEu5+8zA7UQ6+fSJwe+m9XAbycrg2SheA=;
        b=GwAaing/oXEo69f+bXgeoF/PTRwB/dtsIw18qez6Tb3cJoJX7FEZ+32KLJoVXD/snV
         9S4hbZHaSmmeJjQhnRnS9WGnWra1TcXxjIH28xxj71Z6gMOF5lg3uapybkYjFYY4iGjb
         p5amI4mZlJfvuz8b5c78mAHBPWZDFEOcitFrpzAoEJ1rtNL2ygMoBEbvCji1yJzrpUrS
         lSxb2665Znl/bfdRTAJvYDwRdgZw4MnGnPGzbZEjtSyhdzA/AudcDVJ+JX2i5BhrLY0s
         WKK/cWq9vV/K7wxJ5kVtqqQkw4JgPABnNhEntAl3ivAwVTB+yzE7f53Y8k/MRqhR1NpW
         c4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBgdeB7eNpLEu5+8zA7UQ6+fSJwe+m9XAbycrg2SheA=;
        b=XhVoSdmlv1CcHNCm/RgzBAM1s89U6Gj6ILW7kL+/Onbz7+IKYyw80gRREr0/ry+Xl1
         Pdr/K1bsOaNLDHUqF3CsGsQoDfvreMBhhWlIt6/0ToxzFz5ESV0Fu6zvK4Gf+1nEyWiR
         mLIst2vQyfBolxX2UmaF0aG1rIq7SfXH2sZegmgUFhZvDDPpBXg4Es7VI1Nz44Z8nrJd
         qFPBUAhN6iTe7/Q4tmdqDL6JrcFoKfxYJWC4VXYsijDwC97k9YsgmipmsRu+KzzgZzcD
         aUnh763T6R0iL8oBaXHvn3MvNLCx4mLFQAZ220SORFazYPMuJhoZ/xzr/6dqInyrrUmD
         eZUw==
X-Gm-Message-State: AFqh2kpcmPudfnynKGriOs6DTjc+b4Wv6hYpYaeqtiTGGwQ1hE77aQxO
        vlusEXDzcuEtsBODMLKE8NQ=
X-Google-Smtp-Source: AMrXdXukXU93pCQUwsS7Ynpi03C8Nso0gB8SLrDRBnhrjJNQELMTpcNZ8qRJ7Xu25GsW51jGHJQXLA==
X-Received: by 2002:ac8:5284:0:b0:3ab:b6cd:3758 with SMTP id s4-20020ac85284000000b003abb6cd3758mr42754491qtn.54.1674570894295;
        Tue, 24 Jan 2023 06:34:54 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:f993:8512:855f:93c3? ([2600:1700:2442:6db0:f993:8512:855f:93c3])
        by smtp.gmail.com with ESMTPSA id t8-20020ac87608000000b003b642c7c772sm1293673qtq.71.2023.01.24.06.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:34:53 -0800 (PST)
Message-ID: <defd6445-a6e3-8d81-c9e7-f1dd343e7875@gmail.com>
Date:   Tue, 24 Jan 2023 08:34:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
 <20220624034327.2542112-2-frowand.list@gmail.com>
 <20220624141320.3c473605@fixe.home>
 <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
 <20221011092654.6c7d7ec3@fixe.home> <20230109094009.3878c30e@fixe.home>
 <907b6b75-55bc-b38c-442b-4ccb036a3690@gmail.com>
 <20230110091206.72c3df24@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230110091206.72c3df24@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 02:12, Clément Léger wrote:
> Le Tue, 10 Jan 2023 00:27:16 -0600,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> On 1/9/23 02:40, Clément Léger wrote:
>>> Le Tue, 11 Oct 2022 09:26:54 +0200,
>>> Clément Léger <clement.leger@bootlin.com> a écrit :
>>>   
>>>> Le Fri, 24 Jun 2022 11:44:07 -0500,
>>>> Frank Rowand <frowand.list@gmail.com> a écrit :

< snip >

>>>> Any news on this series ?
>>>>  
>>>
>>> Hi Frank,
>>>
>>> Do you plan on resubmitting this series ? If not, could I resubmit it
>>> after fixing problems that were raised in the review ?  
>>>> Thanks,  
>>>   
>>
>> Thanks for the prod.  I'll re-spin it.
> 
> Ok great, thanks Frank.

My apologies, I haven't done this yet and I'm going on vacation for a week or so.
I'll get back to this.

This is one of the three items at the top of my devicetree todo list (along with
Lizhi Hou's "Generate device tree node for pci devices" patch series).

-Frank

>>
>> If I properly captured all the comments, I'll have to implement
>> Rob's suggestion:
>>
>>   "either CONFIG_OF_FLATTREE or CONFIG_OF_EARLY_FLATTREE will need 
>>   to become user selectable."
> 
>>
>> -Frank
> 
> 
> 

