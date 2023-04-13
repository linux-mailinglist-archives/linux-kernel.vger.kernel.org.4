Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C066E0C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDMLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDMLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:31:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D49740;
        Thu, 13 Apr 2023 04:31:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DB3A6603212;
        Thu, 13 Apr 2023 12:31:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681385493;
        bh=KFjJyN/GRcVUyM9+MD0q8eBTa213wPHOvUrosvi9KxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ikY8B1YFvFqMNo5q9NG4TZ2rG1qvlPBJlAHeyu8lM2Ptd51JGYJq+66Jt85CHSgfs
         epp6jgYMRQVsn/apQLHRYEf8DkVcWeNL9UqSKfndnNXUXhUQlWI0Axcmjk+Kx/s7WH
         yGdT7V47aLpVcWEnYoPX/5M19y3rsLE+DhbxNU1ng4og2zAIQhWspXZjlVgvnYyUt4
         Oj8DtNwyWm5KIRbJVRORpGnqLX42Z8j8K6PgUi+a9uHCNtz1XyQzB2gkkZwiNvU3iV
         bTufsRZhpRzYgznf7PlP7ypF0x8CR4pf/MPlEhgzmCHHLMxrHYjBYnQyWRpLySsaB/
         eSWkFQpyaC7GQ==
Message-ID: <dee54623-9065-98e7-0505-bdb08ec1e643@collabora.com>
Date:   Thu, 13 Apr 2023 13:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 0/7] Add support for MT6331 and MT6332 LEDs
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <ZDfeKhUvo5a9jd9E@duo.ucw.cz>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZDfeKhUvo5a9jd9E@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 12:49, Pavel Machek ha scritto:
> Hi!
> 
>> Changes in v2:
>>   - Rebase over next-20230412
>>
>> NOTE: Since v1 of this series was sent in Semptember 2022 and got
>> ignored for *7 months* with no feedback, I'm retrying the upstreaming
>> of this same series.
>> There are no changes, if not just a simple rebase and another test
>> run on the same hardware.
>>
>>
>> MT6323 is not the only PMIC that has a LEDs controller IP and it was
>> found that the others do have a compatible register layout, except
>> for some register offsets.
>> The logic contained in this driver can be totally reused for other
>> PMICs as well, so I can't see any reason to keep this specific to
>> the MT6323 part.
>>
>> This series brings meaningful platform data to this driver, giving
>> it flexibility and adding support for LED controllers found in the
>> MT6331 and MT6332 PMICs.
>>
>> Tested on MT6795 Sony Xperia M5 smartphone.
> 
> Please cc phone-devel with phone related stuff.

Sorry, I completely forgot to :-(

> 
> Can I get ls /sys/class/leds on that machine?

Yes you can, but that will require some time, as I'm on other tasks.
I should be able to provide that next week, sorry for the delay!

Regards,
Angelo
