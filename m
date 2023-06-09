Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAC7298AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbjFILw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbjFILwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:52:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F63AA4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:51:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9745baf7c13so254738266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686311502; x=1688903502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8T0wN2xyHqkgu/5OvE+DJyHc6IdgUb7ALA/gkh9SISw=;
        b=R6Y0oCxUhD2vEYpqllcsJqc1+F/482gIVAuE9WtvwhqwEP9I17G+luiaYk3DpqYZ2t
         FQPUR3S0cpdiCiLkOLlMRLZ3r1oCUnxRQnFCB4EIPupbl63b2ly7Hg/R7WcPIB5fgnQK
         zl+gZrt6jPopzygQE0iBq80u3eehgDL0vlldGIXRouKSCBscddlkVmLctx4KK+K8Xu7D
         urK9ed1G9yQ0qDI5lpoK71WDo7EnUh2vYQ7U5er1+hTQyB4hQSsOv1ueiEJ39d7R8t2x
         D34opUNIU0bAr2tnBqezuIoTE3lE1q8AR0B7R8locsSBVe0i/s/9dEwI+lQKdZxOeBIw
         VoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686311502; x=1688903502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8T0wN2xyHqkgu/5OvE+DJyHc6IdgUb7ALA/gkh9SISw=;
        b=lbsldIyOUYJLwglXBAPWsWJZ/XrP9c2zqFyW94Qx3/Tj0Z7nxcOGnEWv8L/VlKcJ1J
         wsS87Nf8B+yZ0aoAi3JSwSrx1XMdV5sF9bX7nMTVBmZxRK7tRsf5hCMdWaLzS/G857Sm
         gtOIT5OSvwPjynf/6E5eXmmXb2+FD/kW1mO4s4i6eAqViMh4xEA19MZ4FXV8pklus4//
         JkNWznC0MhGhAp24QKeLeBeqeSafzTIwBXmgLx09mce0CiKWdCFoiwDaufDXJeZljCDb
         yTodrWmeWuEcyoUiOYW0Z++TbJI644YUfGGyO4vQi24TTJ2D6qyDS3ceQp3tbZU076Wr
         7s9A==
X-Gm-Message-State: AC+VfDxl1tQrrkzLzEw2qo1O+9IDKx43sjaWGeFbtgzJYcLYc3hPaMoe
        5zn9PB8CJcnF8HP5KS7fpueOlLN53sZY6KCVZcs=
X-Google-Smtp-Source: ACHHUZ4ZX0E/X/YKvqntJSvw3Tv9/5A0eEJHzdaINnGFUFFPTZjJm0mPy2wbX2mDTVvwXuPdfsrBOQ==
X-Received: by 2002:a17:906:fe03:b0:974:1eb9:f750 with SMTP id wy3-20020a170906fe0300b009741eb9f750mr1421632ejb.36.1686311502112;
        Fri, 09 Jun 2023 04:51:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906548200b0096f5b48fe43sm1193972ejo.47.2023.06.09.04.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:51:41 -0700 (PDT)
Message-ID: <56eff2be-710e-cf3a-0dc0-d0f1d21c8825@linaro.org>
Date:   Fri, 9 Jun 2023 13:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 06:45, Christophe JAILLET wrote:
> If clk_get_rate() fails, the clk that has just been allocated needs to be
> freed.
> 
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

