Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48566675BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjATRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjATRpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:45:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6C613CB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:45:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d2so5498158wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITrHzOf8CKzZHcJVI4oySCEV/yvLiFbjpZwlwcszVrM=;
        b=t1g7QuGRF/LxwA08JkHwpsauN7iAMWOwzwhK2UUogmwhlwytg5CISmVuqf0HNHZni3
         gqYr8qtXx8BQbqGlIdI74cp1t1hQbHPM0ks9b/H1ym5cYTCIFLzmVtcIRpSNiSSlkZxY
         0qhrtI5nBy/0WpiQgQIhfrTNJd0leNAd5cDVf9CnymfL7ur1/hHq0Y5eL2oHsL7OBlkQ
         z368ELgVWhOTJPpZSptOCV00FmlBXSAvt6iAz11tfpb7lq7+62Y6FKVl2JGsGM8VjQmu
         z8WSjBMrL1bQpspE+xJbhkpMPjt/jAH9Wtxl9vYGKq8T8730CZ85l/pr7dDs/aPolkhM
         5Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITrHzOf8CKzZHcJVI4oySCEV/yvLiFbjpZwlwcszVrM=;
        b=zXJNnqeaa3/dE06HEalbolfiP0izfxic/pwsD3+ZRFS13qXjN3jCrweYNEnjDFxZR8
         JT7JVQdMWC0sF778Kt8XPzDdi/ZOYdGru3BmJiELJISZ3uzNBL+vRKLI8GNwKDqt6ywd
         ECk2C4+6R3nRu6TXAJfNko3zTWl00DvPDe6kjQZV0lDZ9mZY7zggSBQgoWNMwv7LSEv+
         xAwdpG9eWb863/EEQXVwK/CRDgu9Xvs1hjI+bpeJ7XCzfwCE3SdFLP9e6qjeIWjQbvtR
         SvLf5lqn/wCKkx6XvFm6tiXmVnUPkL8cbdnbIBQevoXC9JXr7Hsif1clL+DHO8DZ9MFe
         xgnw==
X-Gm-Message-State: AFqh2koCleKNBGFPhwk3ujGsi7bMm9b7xuXL3Z/MGJawDZQubaA3QT8s
        w4BmSaojI1iiRE9Av7xA/XAUnA==
X-Google-Smtp-Source: AMrXdXuZbvG+N1C77yl8NUtacT7Uf16JHLryuE9TCFqZtt/bdHghp3X2uz6RkS1nkg8wN5D33rY5sw==
X-Received: by 2002:a5d:5d8a:0:b0:2be:3ccd:7f35 with SMTP id ci10-20020a5d5d8a000000b002be3ccd7f35mr7029265wrb.34.1674236741211;
        Fri, 20 Jan 2023 09:45:41 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id by12-20020a056000098c00b002bdd8f12effsm21114789wrb.30.2023.01.20.09.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:45:40 -0800 (PST)
Message-ID: <5bee7266-dfce-55f0-3837-6fef384ede77@linaro.org>
Date:   Fri, 20 Jan 2023 17:45:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: rave-sp-eeprm: fix kernel-doc bad line warning
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20230117070240.31520-1-rdunlap@infradead.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230117070240.31520-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2023 07:02, Randy Dunlap wrote:
> Convert an empty line to " *" to avoid a kernel-doc warning:
> 
> drivers/nvmem/rave-sp-eeprom.c:48: warning: bad line:
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---

Applied thanks,

--srini
>   drivers/nvmem/rave-sp-eeprom.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
> --- a/drivers/nvmem/rave-sp-eeprom.c
> +++ b/drivers/nvmem/rave-sp-eeprom.c
> @@ -45,7 +45,7 @@ enum rave_sp_eeprom_header_size {
>    * @type:	Access type (see enum rave_sp_eeprom_access_type)
>    * @success:	Success flag (Success = 1, Failure = 0)
>    * @data:	Read data
> -
> + *
>    * Note this structure corresponds to RSP_*_EEPROM payload from RAVE
>    * SP ICD
>    */
