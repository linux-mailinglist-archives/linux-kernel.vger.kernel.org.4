Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F262CFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiKQAfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKQAfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:35:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9FD121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:35:05 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so432894pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmvJEwiZ21xXLrZBi1WIG/q1ERap31TpLTpBBT5zmxU=;
        b=cakRGVlFP4zUUwjnILOJJPN0XKbQNn0ZanA9TWdtV07Sm+c6Bw6IqGBgu3qize0fev
         s3xAxHQe/+6KbKtzhhRRZngAIPva5ZZ0QfQCpQ4Ky/icC0A10gkkNIo0Yc0hMvcoom1H
         H1hQRpPincosjsYy1r4B9an3mEa3ozSoAZYXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmvJEwiZ21xXLrZBi1WIG/q1ERap31TpLTpBBT5zmxU=;
        b=x1fjcO1RZpk+6zelfS5LiFnB8G2qi15tlPmYOihguBCddX8Jh8Mjy80Ai0xQL7ei70
         HJXGczaMYaGgiw4yKqOYouXTAlRSQ1VhzvsRBldnDhezCFuRS/jR6fDfHHVtcg0UgJ4K
         Qxwy6JKVuoasXUsLMkVBwWaUiq9j9yTZdv5VdqjSVipKloErmixKW/K90V3l2rL7/OZa
         NebF2+c+0HA0OMHcjNyqCeyMLtzC4kl3DwU+qk5/mUVjM0HKayTkaEGFNTehmp+JeDRu
         h/+ZXtXhmuHawETL/O+8NhtdB05uFGSbkC495szMf2cc3vqpL2Y5AVbWt7lDst32hJ9a
         Lieg==
X-Gm-Message-State: ANoB5pn7IKWkorT6cmcjEHUTzECsJnjTqfuxEi+7KHkhcKyZtV8FFWSj
        dkA5oKuYmpOzm2i+/hteBBn9sw==
X-Google-Smtp-Source: AA0mqf7hGFDPMqrXLDMFH04Laqegvn/zp/DoAbfPZEQx8qVyF2TAzljQnVqhbhiC7J0cic+rnY/IhQ==
X-Received: by 2002:a17:902:c085:b0:186:fd58:c700 with SMTP id j5-20020a170902c08500b00186fd58c700mr274156pld.119.1668645305460;
        Wed, 16 Nov 2022 16:35:05 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d87c:a39a:d965:288])
        by smtp.gmail.com with ESMTPSA id c133-20020a624e8b000000b00572275e68b2sm6980384pfb.116.2022.11.16.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:35:04 -0800 (PST)
Date:   Thu, 17 Nov 2022 09:35:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: replace one-element arrays with
 flexible-array members
Message-ID: <Y3WBtLYcBonVrJio@google.com>
References: <Y3OxronfaPYv9qGP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OxronfaPYv9qGP@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/15 09:35), Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structs in fs/ksmbd/smb_common.h and one in
> fs/ksmbd/smb2pdu.h.
> 
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy() and help us make progress towards globally enabling
> -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/242
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
