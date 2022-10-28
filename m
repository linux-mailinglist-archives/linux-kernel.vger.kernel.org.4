Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E6611E44
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJ1XrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1XrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:47:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DDB1D5E3A;
        Fri, 28 Oct 2022 16:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A38D5CE2F6B;
        Fri, 28 Oct 2022 23:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16871C433D6;
        Fri, 28 Oct 2022 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667000819;
        bh=hB5fE6S2HQ2dHPl7HVJSxxHZcSmMmavYRsA3XNFzfwM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c+IMnUh0cw/5I9OwpiVH/87RYGhRzQcEY3LqtjiL4TOTD/mWeymZWRyBuQhoFftq4
         SjAHCsDgyk0WIlHpVUZ4nvg44DzjbYR7iRq/t+1oNpSyDbD104TZ3O1HLnEJ2fAGC1
         +Sj3j/EbDe/kJLer2o+/9kfm9BvS9V8yuCScICsdAWBac9MgrfzjHbXqnvuLs9sbVJ
         OdZhjO0oMDHvnOhqrS+HFTFD+yONBWYSSSkYRRhOHPr/xY0hXLmOAG7kznEuNmWj6k
         O0jDOMiNfIreJW3/wo7WTSlRliOUEGYknlJvHW5xZx9yezMPuyNoY5jYk0BFCRfn4o
         w7szPXFkQdumg==
Message-ID: <d5bb33db-5c26-fbfa-0d12-46ca41d80785@kernel.org>
Date:   Fri, 28 Oct 2022 19:46:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
 <20220930145701.18790-11-trevor.wu@mediatek.com>
 <166457526101.1112313.13428811477972046652.robh@kernel.org>
 <ac5d872ac8dfa40bd5238589f85d78ad6ba6d706.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ac5d872ac8dfa40bd5238589f85d78ad6ba6d706.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 23:57, Trevor Wu (吳文良) wrote:
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit.
>>
> 
> After upgrading dtschema, I can see the problem.
> I will correct it in V2.

Correct also cc list.


Best regards,
Krzysztof

