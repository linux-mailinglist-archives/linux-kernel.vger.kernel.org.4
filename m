Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24458725821
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbjFGImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbjFGImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:42:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6264C1721;
        Wed,  7 Jun 2023 01:41:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9745d99cfccso985665766b.1;
        Wed, 07 Jun 2023 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686127316; x=1688719316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVvlvoB02nvnsnKJNEtRpAZOz6oiby60WKtoUe7P+GY=;
        b=OymjuXBxiDerqwX3JfzNWdavhSO66hb6xPOM7aTrHoDtyvTeMGIjGNXJgc/zIGD33g
         eYqzWP7xsgKxyYG1GfcRNFJOf+GIf+DFQ018pqJS3qIerqbN1w9VnvbeyWs4prbWw4/E
         SduzQmsPqRBBMt/EgwRGfaVHLoFqvJkmO2G5XQmygRQlWGQG6tSl0/ORdF5DcZ3b0CDv
         x3AUpfipt/L6Jlu/RRsiN9RZxRT+SoecO1rHLbT7bK8yVuTlFICYI2feiT7GjTDUkAHh
         4FfBm8dEuDoPb7MqApaAsMWr0D7ivwCLjTDVegufSba7A6JrgNVFqqBdBOku0hwuHEqs
         PiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686127316; x=1688719316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVvlvoB02nvnsnKJNEtRpAZOz6oiby60WKtoUe7P+GY=;
        b=Pk/bda60eS816W/Cx/r/mPI7+hEid6ykrqJKuYC7/MvaEq2wCJez90ZJwOB6B+UxHZ
         PMS5eUXoe6ZEpZ/OIfiecISQXGioMGUQ2iuOMRAZ5YOYTpw7O1cV9ulNfjay9mRHWTvK
         vBEoUzlNnFavnMNYc632xFYJ+f+y2iz0pXjWgtwuHyH6Mww0lLAz2MwXPdZljyHnwYPa
         wfG6FERKVKwQ1so8Pz8PVoz0AShYBr/EZQ0uiSF8hJXmX9ehh2M+JB5u8Tw5HD3XwOt9
         AHQBmSDGUnWgB1DF1iLsOIX0QNVilq3pucFJby7bPeP5LZmrP92ybUU6HTk+7NWkOYnU
         bjxw==
X-Gm-Message-State: AC+VfDwK31ijb3ssa3/a3suwf5coA8N1Ao9PQtqRM/1m9foJdloL0P/s
        pl0HFzpnYsyHe9ULL9/KUEU=
X-Google-Smtp-Source: ACHHUZ6YjASw/aH/Db8HdCXMq296JKT5ZbfQIIRMgoA3Vta/rnzJSGSa6oM9bwmVzBHkB17IH6vRzQ==
X-Received: by 2002:a17:907:608c:b0:953:517a:8f1a with SMTP id ht12-20020a170907608c00b00953517a8f1amr5154659ejc.58.1686127315448;
        Wed, 07 Jun 2023 01:41:55 -0700 (PDT)
Received: from ?IPV6:2003:c5:871a:eb:baf3:f2aa:5a58:4b8a? (p200300c5871a00ebbaf3f2aa5a584b8a.dip0.t-ipconnect.de. [2003:c5:871a:eb:baf3:f2aa:5a58:4b8a])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm6664908ejb.35.2023.06.07.01.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:41:55 -0700 (PDT)
Message-ID: <ace67990-3873-5e5a-73af-00ba573c917e@gmail.com>
Date:   Wed, 7 Jun 2023 10:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ufs: core: Combine ufshcd_mq_poll_cqe functions
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        bvanassche@acm.org
References: <20230601225048.12228-1-stanley.chu@mediatek.com>
Content-Language: en-US
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230601225048.12228-1-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.23 12:50 AM, Stanley Chu wrote:
> Currently, ufshcd_mcq_poll_cqe_nolock() is only called by
> ufshcd_mcq_poll_cqe_lock() with the addition of a spinlock wrapper
> for ufshcd_mcq_poll_cqe_nolock(). Combining these two functions
> into one would result in cleaner code.
>
> Reviewed-by: Bao D. Nguyen<quic_nguyenb@quicinc.com>
> Signed-off-by: Stanley Chu<stanley.chu@mediatek.com>
Acked-by: Bean Huo <beanhuo@micron.com>
