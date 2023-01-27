Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67867E51A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjA0MZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjA0MY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:24:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FCC271D;
        Fri, 27 Jan 2023 04:22:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C50FA1FF3C;
        Fri, 27 Jan 2023 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674822164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDFxmP6Jju2VkC5BkZQ5ZseNFE1FZZ99uPy0Yafpgrg=;
        b=VziW0VgOOGk4av32YjquoTXHH1O2Pe4kuU71FC04P2AgFTiZr+uEmKMb5TNyRwar70eZxV
        Wup4xBVClb/Ftyud7FY6ImMjHRdFZNAN1vcL5tyk+hEUJ6BXBD2oyDw8JFsZ2UlDhzfXPy
        SIn+7jAsC3PK/50GIENdEXuvnkXqcjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674822164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDFxmP6Jju2VkC5BkZQ5ZseNFE1FZZ99uPy0Yafpgrg=;
        b=p0/K9rm4AlCr/xOaghy0J8nLgOp7oIzZYPJnASwoUnRgrR+pGZuQ+yssOiWyz6bLv3yPKh
        +QGjkHv5EmCOtWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DAF3138E3;
        Fri, 27 Jan 2023 12:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zwR3JRTC02M/fQAAMHmgww
        (envelope-from <afaerber@suse.de>); Fri, 27 Jan 2023 12:22:44 +0000
Message-ID: <a3ca0bd8-2153-cf69-adf3-bc92a31d0efb@suse.de>
Date:   Fri, 27 Jan 2023 13:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: realtek: align UART node name with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230123151514.369101-1-krzysztof.kozlowski@linaro.org>
 <167481277324.62929.7688485206150758782.b4-ty@linaro.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <167481277324.62929.7688485206150758782.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.23 10:46, Krzysztof Kozlowski wrote:
> On Mon, 23 Jan 2023 16:15:14 +0100, Krzysztof Kozlowski wrote:
>> Bindings expect UART/serial node names to be "serial".
> 
> Applied, thanks!
> 
> Let me know if anyone preferred to take it via sub-arch/SoC maintainer tree.
> I'll drop it then.

We did have an equivalent patch in '21, from Zhen Lei of Huawei, that I 
gave a Reviewed-by for. So should you maybe apply that original patch 
instead?

Reminder: My Realtek testing broke when someone removed upstream support 
for adjusting the text offset (they have a boot ROM at start of memory).

Regards,
Andreas

> 
> [1/1] arm64: dts: realtek: align UART node name with bindings
>        https://git.kernel.org/krzk/linux-dt/c/5ad30c5fc0a72c2aaa1d26f9e4061d8646231adb
> 
> Best regards,

-- 
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nürnberg)

