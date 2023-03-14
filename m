Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C220D6B97D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCNOXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjCNOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:23:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB49AB889;
        Tue, 14 Mar 2023 07:22:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so6239781wrm.10;
        Tue, 14 Mar 2023 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678803754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXl4TgI3IpmiTT3XmEwykC+oT2OJpvBfbKn8ITV5+I4=;
        b=Qd6udfidgl6S8YWBabq6CfpDGX989xxqr3fu4G5b//IdS31IGCKZBJbJEHOvlLqI6o
         kTGLQS8hg3GLfjSKFTQUyOeD4mBD7OwYQR5w2ciFzsSunlinEORfUJTS4RWfC4pqcIm/
         gs5kNTkZWG6QOSDzG8IP8Gb8lB6wa9FR8VvtNlii+RuL6oFHWY1R+LYHfrqU5P7ibCu3
         pmtN04IcKGLw6HJoYeYYr7xRJhel2QFlTlXkSJtyq8K+lHW3UKN2lAFYn/1t8XikuRnB
         VrcVMxEvKqwVD9oQevkzfe1ly7AR9hKeYfegVU85TlnAzoZ/wOD7I/ooRwSxxFD3qglM
         5BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXl4TgI3IpmiTT3XmEwykC+oT2OJpvBfbKn8ITV5+I4=;
        b=qxESJW4XMZqMq9KAPUpO/FVzXqGqkEdjfqs5zP7ZU1yFIys4PqtUUuOD078g1Z8uVT
         wNl4AuC/3zHHy53wC8rsHhXbvUMDpLHB/yuBVmYYbptSM+6ntFrqh48jhnYZwR/p4gjH
         aUhCShrRgNfH8910ILZxvZNhkT4241oo10ys03iG/R+JBv0NRIYCqKPKLpvVb3jItCfb
         cU/iBDyqkORXZAwr24SilAEMRbk+WC7OfSiOwftspRtGl0ZGnauMyJfocEBpGSw9JdDq
         /nk09a+h5pC3WXOVGtVNtdPkFTBIgH4SNEnLbiUU2MnsDwSKsr6AS/8nONH+SiZfIIm7
         cJgQ==
X-Gm-Message-State: AO0yUKXqEPxrCioYutkn/aJ1EkJKYuphAJcSdBRjIXYotINBuoHg+Xtm
        hbc2biz5VLr+FHLt9MFXh6o=
X-Google-Smtp-Source: AK7set/qjMFLVqloraRunzYDMxB3B+4nSWcH4blFYg7bum9qXDXw/ldPZeraNtS5HiDOTxsoaR+fUA==
X-Received: by 2002:adf:f84f:0:b0:2ce:aa62:ff73 with SMTP id d15-20020adff84f000000b002ceaa62ff73mr5480045wrq.54.1678803753757;
        Tue, 14 Mar 2023 07:22:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d4f91000000b002c5598c14acsm2315939wru.6.2023.03.14.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:22:33 -0700 (PDT)
Date:   Tue, 14 Mar 2023 17:22:28 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
Message-ID: <155c581f-1a3e-4d6c-82b9-0ff7855dcaab@kili.mountain>
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
 <20230309040107.534716-2-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309040107.534716-2-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:01:05PM +0800, Dongliang Mu wrote:
> The previous commit 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix
> double free reported by Smatch") incorrectly handle the deallocation of
> res variable. As shown in the comment, intel_vsec_add_aux handles all
> the deallocation of res and feature_vsec_dev. Therefore, kfree(res) can
> still cause double free if intel_vsec_add_aux returns error.
> 
> Fix this by adjusting the error handling part in tpmi_create_device,
> following the function intel_vsec_add_dev.
> 
> Fixes: 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix double free reported by Smatch")
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---

Yeah.  These patches are right.  The earlier fix still has a double
free.  Devres stuff is confusing...

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

