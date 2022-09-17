Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361765BB5A1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 04:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIQCrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 22:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIQCrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 22:47:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F973BAD8D;
        Fri, 16 Sep 2022 19:47:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d15so17082890qka.9;
        Fri, 16 Sep 2022 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=90zw/hXCi4Lualj1G3WPNVCGMP42ucL6n83ggKg1jec=;
        b=GURJcQLEVCa/Qx6sLOQG9JqUPk172By8NbCLIiB/p3ZodyOFJBLa2Z4Jt0GQOyH8oj
         25uACn2E7LDKWds2XW0TZy0nab0Fi67kcthInqMoXKhJlyKND5P+wWflkQ2OQpqB1H8S
         fC+E44xVUs+PtpHByc9wMgrxf+dwXh5lJMToIZrywgGLYmQgOmD2yK0nzAOQdOPNFNmN
         FQrMSddrpzORZbvYQMHZ5oRtwhGzxQQlD582f+48HvGP5eSQBqAMjrYoQwqFykweOyYf
         +QX5v56mG5x8rukElKquOyMjENiqdJYm2ONdD5qO3Kzhm2uAnWPqMZftigXK1ma4E31D
         nh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=90zw/hXCi4Lualj1G3WPNVCGMP42ucL6n83ggKg1jec=;
        b=AshwEojiMhAY4n7aKkIa8hXVF+MYek8Kj/GQQWGPvYWlMgXBC6M1VmJBf+ItFjfFm2
         E5KEl/o10J5AzeUeuEIO5+7zVKcqvl5+yKxUonRtFa+Z48goKTTHLwh6pcS6pztjLA5A
         cCpL10XbxeZ/Q5GabKxZDdXu+azzahpyvRfH0X9TeP6k1dCuGv+npaXvRQ2Nig+p90lx
         M4nbt6hgykcFq3GdOv5CPLA6MrnrAx7l8dEA97uXhOZOqslrIO0OHKPTLQiuhvgOoOd5
         dDNDcTWfQrr7qlJcrnTb9RHDOGFEwLZ2OmSX9ZZ5uV+huwS+/jMIFvLSx4kuzfBLbi6A
         DhqA==
X-Gm-Message-State: ACrzQf20xQBFJbNXe0QFELlVzcF1laWmuSZAqGuLgKWCzaO0kzmz17IJ
        33KtNZPI1geyQ4Fgp1ZaRAM=
X-Google-Smtp-Source: AMsMyM7+KHN7F20gbYbTJSVaakJI/6w2k0n4Au2gaGejO+tDqLRvgq7csScqmDMV7hJPvT03aia48w==
X-Received: by 2002:a05:620a:170d:b0:6ce:9bad:13c6 with SMTP id az13-20020a05620a170d00b006ce9bad13c6mr6066782qkb.683.1663382840489;
        Fri, 16 Sep 2022 19:47:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:90c9:b1c1:5c9e:9030? ([2600:1700:2442:6db0:90c9:b1c1:5c9e:9030])
        by smtp.gmail.com with ESMTPSA id bq16-20020a05620a469000b006ce611aef61sm7287745qkb.95.2022.09.16.19.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 19:47:20 -0700 (PDT)
Message-ID: <b6a43df4-e5d8-06d2-a6b9-3626f2677161@gmail.com>
Date:   Fri, 16 Sep 2022 21:47:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Content-Language: en-US
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
 <20220912170524.GX4320@zorba>
 <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com>
 <20220913005153.GZ4320@zorba>
 <00850627-7ada-3a02-158c-30f3b8334d51@gmail.com>
 <20220916225646.GK4320@zorba>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220916225646.GK4320@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 17:56, Daniel Walker wrote:
> On Fri, Sep 16, 2022 at 05:47:54PM -0500, Frank Rowand wrote:
>>>
>>> Maybe you could add a flag or other indicator which would indicate the overlay will never be
>>> removed. Then your code could rely on this property to inform on if the author
>>> has consider the removal issues related to overlays.
>>
>> No.  I guess I wasn't clear enough above, where I said:
>>
>>    "And I will not accept a
>>     change that suppresses the message if there is no expectation to remove the
>>     overlay."
>>
>> There are multiple reasons for this, but the most fundamental is that if a
>> new overlay is not removable, then any overlay already applied can not be
>> removed (because overlays must be removed in the reverse order that they
>> are applied).  It would be incredibly bad architecture to allow an overlay
>> to block another overlay from being removed.
> 
> So how about an option to turn off removable overlays entirely? As far as I can
> tell it's not used currently by the tiny number of implementation I've seen.
> 
> Cisco doesn't need it, and we could have a smaller kernel without it.
> 
> The issue is that the error log on blast is log level abuse in my opinion. If
> there's no way to fix it, it should not be an error.

The way to fix it is to not have a construct in the overlay that triggers the
message.  In other words, do not add a property to a pre-existing node.  (At
least I think that is what is the underlying cause, if I recall correctly.)

-Frank

> 
> Daniel

