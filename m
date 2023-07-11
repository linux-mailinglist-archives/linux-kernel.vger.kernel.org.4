Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9767674F15D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGKONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjGKONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:13:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837F10C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:12:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso9103087e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689084777; x=1691676777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1fbuyyHBhIuF5nyqzFugyaIZTJIbSDFsHroF6nZIpo=;
        b=juJrc22D1McA7Im8Wop101SrFYgYCxmoJMdwXAA2HuChKSpq+tQn/+57iCG4d1hrXk
         es2Mb21nVJGQ61u5g3xBFc72OGq3mU7DGiAG1mZnklLQFIWeCJCsD9HGmyV6NsaJ++Oi
         g8W+zN11ZrCvaxwJONFUYBbLpfyQi7nAIILlLcVDdO0OUYY2MVgvXDkvxGBahYF33ZWz
         AldpviSQurwxLi2a6eYkiGS2IOUHz6fqCfP4XeJlf/aD4P/roJkZnbRBJDvI3e6YLoQS
         P1QcpARO4VB1ij+NEcCEcOxoLBJQszZHLoCpQAWTfny40MWZj0vezCqar2T6vZwQqSlf
         WkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689084777; x=1691676777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1fbuyyHBhIuF5nyqzFugyaIZTJIbSDFsHroF6nZIpo=;
        b=NR5tQ9ZD6ejOjXYCqq8ZXJ8kD02WtrDcEw/4mSQoPRnD6qeo8XKcaL6IojGqv+kRlJ
         7VRgUvXLPmamZ1ScSzxVtlfEKPPqHKVMgWLqiLXrhNEj8g0MLBZu/Nxwl8LqTpM0RpA/
         6unTyvJtcbWq8RdJJiN1yxS9HDX+5R3rqyCHtQirWqtK2fxKElmqKqzZgkv82Vt4bJgz
         1kb6TEhIXScd+1lW8H/RHIO84t9FKSJ5bItEbPjIT0u+qz1NI5/lCUWgGa/4Lifm+FOL
         Td8MsehK+9ceRC/EcaJZUgioZVyjc5fwfWqiIBvIBDfqLpBPWPOrn+msisniqLUD7LzN
         EJhQ==
X-Gm-Message-State: ABy/qLZg48qwva2b8/xhwAv6ZTN+zlr251305nBNLkO+fzkncL20Sj7I
        yqQSjeYJOKrrfCWWzTvDj1ot/Q==
X-Google-Smtp-Source: APBJJlFYEhpgZchwp05wacSRqwEEdDAzahNIsZyyCbmLXoW12nKKAzckLIJmtg87KyyMq5LKUAG4Xg==
X-Received: by 2002:a05:6512:10cf:b0:4f8:6882:ae9d with SMTP id k15-20020a05651210cf00b004f86882ae9dmr13955377lfg.69.1689084776917;
        Tue, 11 Jul 2023 07:12:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
        by smtp.gmail.com with ESMTPSA id c24-20020aa7d618000000b0051df1797222sm1322125edr.11.2023.07.11.07.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:12:56 -0700 (PDT)
Message-ID: <dba58cf1-59ed-f1f3-fdbe-59d213f0a7b5@linaro.org>
Date:   Tue, 11 Jul 2023 16:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] KVM: s390: pv: fix index value of replaced ASCE
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        frankja@linux.ibm.com, mhartmay@linux.ibm.com, nsg@linux.ibm.com,
        borntraeger@de.ibm.com, nrb@linux.ibm.com
References: <20230705111937.33472-1-imbrenda@linux.ibm.com>
 <20230705111937.33472-3-imbrenda@linux.ibm.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230705111937.33472-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/23 13:19, Claudio Imbrenda wrote:
> The index field of the struct page corresponding to a guest ASCE should
> be 0. When replacing the ASCE in s390_replace_asce(), the index of the
> new ASCE should also be set to 0.
> 
> Having the wrong index might lead to the wrong addresses being passed
> around when notifying pte invalidations, and eventually to validity
> intercepts (VM crash) if the prefix gets unmapped and the notifier gets
> called with the wrong address.

Can that also happen in crst_table_alloc()?

> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   arch/s390/mm/gmap.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

