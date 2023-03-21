Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336E6C2CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCUItY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCUIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34964608E;
        Tue, 21 Mar 2023 01:47:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m2so12792323wrh.6;
        Tue, 21 Mar 2023 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679388454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtHqZkEWuTahdTsop/BgtjQDbajvxIKZBkyXXuaB/ds=;
        b=BmXRwHDNMULR3xIqdzZ2p+gUZ6VX4mh7cM1N3bYfEC2lm9hA75LBXEhmQ3p/pqpx0Q
         jqvx83a30zPxizH5IQUHyQH0bZz+1V1PgfLjoJP6p5p3o7AGt11vwJgZn5UkAWLCcePd
         AGg5MEN9Fv0K7wTnMg/jWVzahMcKQ4iEuoSkZ/EpG1+y0hsLWoEmAZCPsSxZT0xOUPrr
         juLH+FUIbYAgCNLG6OunwSr+Dd8R7XDRpkE97VlqNFbgA8x94ewFh1/+wk0Ngk+gHKUc
         Z1cWt6XOIkfhI3UaGK3gDG5FEjVCnY8f8MjLHmkuej461qdy0YEhwRKPiNimDryIQyYS
         nAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679388454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtHqZkEWuTahdTsop/BgtjQDbajvxIKZBkyXXuaB/ds=;
        b=g9uxLT0u9Wr31kA35krRhc5EBp3AIcQjVAtYp8ZB/gZY5FPvY4+2dTpzhjxiDqQUGf
         0ln6IqCalSZExGVjEQo5yXGmALVbae2moj2DnG+aOe3hNQQFd8DjqPUQRUs37nkdQzIv
         A642Blv5tgGuSM5aiTCBeEI4ERB5L9BAk6xJ1QDMbvaIzbs0UF3S/uW/4ezQvUZXpj09
         fA4VoFoelDmJHrYB2Nr9PvUFF0nkg7qP/jXUpOOD7fJmZewK7pnm9AgOotq9G/4b7gG9
         t5UkkD9I3aXkZ2Z2o8ZxkVvnD9lKULBxucYywkZVuyQNyOaLyMN+CUc+WVic/wgtG5+y
         0OUg==
X-Gm-Message-State: AO0yUKUqdsZ3YUPbGZ7OUIhjNdMo7Olb/HKtOk2E7tBfuJsOwP+2s1R5
        D11H0q3J5Pw2yfY3SWr9xKeX24I+/MIf2g==
X-Google-Smtp-Source: AK7set8J2CvTMs3v7VYwtR9kJTgmjPkUwPYEW1kTBsVsLD7LBfou73qPtnITJr4oCdgBqdjharedpw==
X-Received: by 2002:a5d:6a08:0:b0:2d0:bba8:3901 with SMTP id m8-20020a5d6a08000000b002d0bba83901mr1744754wru.62.1679388454164;
        Tue, 21 Mar 2023 01:47:34 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id q4-20020a05600c46c400b003eb2e33f327sm1924022wmo.2.2023.03.21.01.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:47:33 -0700 (PDT)
Message-ID: <b36aa25a-7cbd-6926-1ee3-ab9b2bf76111@gmail.com>
Date:   Tue, 21 Mar 2023 08:47:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] stress-module: stress finit_module() and
 delete_module()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, david@redhat.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org
References: <ZBUA6E3kYh0Xuu/c@bombadil.infradead.org>
 <ZBkClVqkTp5b+gut@bombadil.infradead.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ZBkClVqkTp5b+gut@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 01:04, Luis Chamberlain wrote:
> On Fri, Mar 17, 2023 at 05:08:08PM -0700, Luis Chamberlain wrote:
>> I'm not sure yet why we don't see the module delete work, I guess
>> because it's refcnt is still not 0 and so the unload probably won't
>> help at all unless we have a loop just dedicated to that.
> 
> <insert self deprecating humor>
> The reason was because the module_name is the full path, and the system
> call wants just the module name.
> </end self deprecating humor>

Ah, that explains it.

> 
> I'll fix.
> 
>    Luis

OK, I'll wait for a v3.

Thank you,

Colin

