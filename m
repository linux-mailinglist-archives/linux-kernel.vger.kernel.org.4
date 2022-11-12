Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5787626AAF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiKLQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:50:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6565AD;
        Sat, 12 Nov 2022 08:50:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h14so6909591pjv.4;
        Sat, 12 Nov 2022 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YtIzIFXCd8ejP+if9R+vz9eE20Exyv5nPauR7eKIuE=;
        b=FRKd65M1dUvUk2bFupd/DigeVgW/VgwGaOAYztLLuFlzxAcskSD4il2H1VfJhSJGS0
         qO+PrstmLwBtYtmPsKxLqQ95eSKNARXfkTX14phinjyEhluyp5PX0QQLRrcrR2CZgi/7
         l9kdgkO5CsbLtC2vP1CSECIJNPWhNv8/ZEoh7LYzdL27CqK6IKrEr3eXTJ+bmdTHZ8cU
         QhgNxeo1prW3PlfF2cOKT52Vsxsu9Oz9L5qYgeA76yuFTwuCo+32n9hll4Eqg0KA2czb
         CKouxmdVw5zV0LhVnE1VC/wTeh/UOGNys2oEYQHUbuLa/S5c9GjAzjtCxpsi+D5Ty0w8
         3tdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YtIzIFXCd8ejP+if9R+vz9eE20Exyv5nPauR7eKIuE=;
        b=w3qApZtaiMn0ReUM7ech+w0tthbVKvJ+vil1aZNsiTx+sI/q9mo3Lz3bS52+CDcrgi
         d0/YgMf8zr4wt0ze18fHuS8HXMLCEeT+LLIxZIN+hPfSyBsB6oz7AiQNBaSdOOa4HNU/
         iQnNMCUESmWGgmQkN1MrJDva+UD88//nD/MVoY2bLeVHSwPgVgU1pDQRm+1R3DhFHuM7
         rnPHC4SO3w1qbiodGgoRuS8nZxAgEEtkYTGeBgBLd/qGQa7bTg8ZKIQfsOGfcSMDT78v
         x5Sz5WbA1BmOR/Aj/GxjHPfwgZTWlca+nY7GkbOHLBzMVte+PAyBtgWYWcTRqe5LVRys
         r5ZA==
X-Gm-Message-State: ANoB5pn9i5ZlPmOwq7SemvJzQJZa21fOty6QZ84ZKyDTOuLWjECbAn8/
        6WQp3d/IOsYdmH/Yk0XhR8eYg2c7+vg=
X-Google-Smtp-Source: AA0mqf6FsHvwljVx9ri2u3GHDOUK+gLojv9lJZe3XTrUeaY53rpL3qiyQk/ApJivBgmtafDHP/NsNg==
X-Received: by 2002:a17:903:26cd:b0:17f:7ed0:2367 with SMTP id jg13-20020a17090326cd00b0017f7ed02367mr7408026plb.31.1668271843933;
        Sat, 12 Nov 2022 08:50:43 -0800 (PST)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b0056bc1d7816dsm3591324pfz.99.2022.11.12.08.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 08:50:43 -0800 (PST)
Message-ID: <c2352c27-fbff-ead4-ac22-3aebf5c600f3@gmail.com>
Date:   Sat, 12 Nov 2022 08:50:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH -next] scsi: lpfc: Use memset_startat() helper
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111074310.132125-1-xiujianfeng@huawei.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221111074310.132125-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 11:43 PM, Xiu Jianfeng wrote:
> User memset_startat() helper to simplify the code, no functional
> changes in this patch.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

