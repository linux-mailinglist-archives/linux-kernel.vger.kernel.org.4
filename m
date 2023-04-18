Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBE6E5E96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjDRKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjDRKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:20:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A89752
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:20:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f173af665fso9671925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681813217; x=1684405217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFy5WUTawpPS84CigK11q6oOeCpJyryq3ERZuBnJrUs=;
        b=a8LydxlGHrJWMKU50xI/W3Xk81UmwhEGdJkB7+kg+gujJh8c/k4LtoPzNi7Dz5RCTo
         oIzXMqOPqjpkxOQJJoX3KFBFhelQQPbIwGYwuS9TvRFjpmI8xYMLeJ7L86rUVQjNACyB
         S1huQyE1S0CHqJZ7qIv41zfQC4EAFiSKagbiQRJlMj5hzVDLDZFBQnnoG0I4VxhSK2db
         uhNEYmsrd5j1a7blk3MC//6c7OHRYcaXqBKemIpfUWuwJ9uAL6kr/Cz+5JZz2ksuPGCm
         khZzjOqUNvKcUWAVNioWyxL87OkKXTlaOfQYoeDRtHB1ENAuAnEzmGk3FwRLYQ7BKk5o
         s98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813217; x=1684405217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFy5WUTawpPS84CigK11q6oOeCpJyryq3ERZuBnJrUs=;
        b=cLoL8eeJkk4nO8LqkKXt6gAMmdFnv1TEac9U9UGX3tn6MqOz/LCeWFZdhwWa+FGebw
         DZvqtwfQi7x/7byGhkL7KtVyydHH4UOPBSfbf/CeeQZUpjeUg15oJ5O2vjnw9snOvJr5
         etkOpP8oGdH+mW+ENM54NwhZ6W9vcZpiAtGn5bSpxjKvQGTT7pQagGFhgqEJArvOg5T3
         +fjeuK0edDKovsiReaNbHRZTVY6qLq73K7ZJW4bU/W8QDSnCekpNll86VLddHs8/fO2z
         ddEMsQh73iCv7o3UsIPynwe4vbI9HqbK83RF/gnlYPobAVQAnXgZLLMJgWIBWyR6XQUJ
         WxNQ==
X-Gm-Message-State: AAQBX9fo/8u2XG5yQSC4inlkzAuDwwWmAGXBOVfeVQSd7vIcXf3pS0Pk
        o3m4JdijIWBwGLi4Yzuq+/2cHw==
X-Google-Smtp-Source: AKy350YlowlrrTynudc7nk7kkuzgJxvGxXqG3PfUaCRPYgnOyUgGJQMw+X4Nu7m24+QGZeVut8vhWQ==
X-Received: by 2002:a5d:4089:0:b0:2f7:363e:7f5 with SMTP id o9-20020a5d4089000000b002f7363e07f5mr1464835wrp.24.1681813216802;
        Tue, 18 Apr 2023 03:20:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d538e000000b002f81b4227cesm8810291wrv.19.2023.04.18.03.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:20:16 -0700 (PDT)
Message-ID: <61926f94-a4ad-92c7-f2b0-036f76080968@linaro.org>
Date:   Tue, 18 Apr 2023 11:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] mtd: spi-nor: Allow post_sfdp hook to return errors
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230405062106.49594-1-tudor.ambarus@linaro.org>
 <ce297db930bab7ed3d72637dc911436a@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ce297db930bab7ed3d72637dc911436a@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 10:25, Michael Walle wrote:
> Am 2023-04-05 08:21, schrieb Tudor Ambarus:
>> Multi die flashes like s25hl02gt need to determine the page_size at
>> run-time by querying a configuration register for each die. Since the
>> number of dice is determined in an optional SFDP table, SCCR MC, the
>> page size configuration must be done in the post_sfdp hook. Allow
>> post_sfdp to return errors, as reading the configuration register might
>> return errors.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Reviewed-by: Michael Walle <michael@walle.cc>

thanks, but I already applied the patch as part of:
https://lore.kernel.org/linux-mtd/168093614108.51189.3153773628255664983.b4-ty@linaro.org/

You can find patches that require action at:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=&submitter=&state=&q=spi-nor&archive=&delegate=

Cheers,
ta
