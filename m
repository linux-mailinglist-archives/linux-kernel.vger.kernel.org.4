Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6416772917F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbjFIHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbjFIHr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D830D1;
        Fri,  9 Jun 2023 00:47:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso10408685e9.3;
        Fri, 09 Jun 2023 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686296840; x=1688888840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3GyzALgiAbKVN3scNeYJuUugUOGcxM8aiFsKeh7Wl4=;
        b=R+uUnQnUw8AxfbwxaV8YiwuF1jLiTqyc3ikoithVKsDf2XRY1Grc2neL5OuPsMvI6k
         Aut8pa1a2xznKmSJPHM79kd4zTp2KNIeOMqs4W3Wjd8riKCaPnH77NhiEtQmqZG4n3NK
         KzQ1qM0MzBY+88JxJK+2WDoQZuavecnHTvzKehTsL7N7zPp0/WZ+PvlMw2mQEpcgkbSu
         yVnxPDfcBhbfvA6vh6cHEdyhrmYkXKbtuup90Sjm/+Kg2+rYjB4OyWcQA/cWvT4GlI4W
         lLXRzq1YM3cJLPIOnE6j7u0TMrthQANIHCdVbhGvnQ02OS0DGXcr847XvPzB3ilzkzXP
         udBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296840; x=1688888840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3GyzALgiAbKVN3scNeYJuUugUOGcxM8aiFsKeh7Wl4=;
        b=Stx5YS4vcxeyGG3nYfMc5/yubY4PaZ17n+npM9KVk6OWt3QlBYAtP56QwE7PN/9lX1
         99jvdFG4AXwwWHFfhnYnTHG5Ekxdz1ysxNHOR8X+LHDZ7JkZLj4niBZ65FkZM9ISvaAO
         liiNbpdLMF/hOIk7b1ANTLtnNNZFbZejwVjh/c6YpDbgIXy58MMC9qvC83Huj/ZKT16F
         oBsIIaeUP1texsHgTEkZOzhBy0psRUizBbB/y4sRkmiHnVqcu31SGVC4o47Aj/fomw4h
         twGU8pU1Hg+U5JhGGezwNDsEvgFPhLMAw5Vj3v+6f4bTgXdVSSptBItJejpFBTiU5CfI
         KuDw==
X-Gm-Message-State: AC+VfDyRR4oHT8y7UXMA85PwRrgDuvEckdAOopafrVLBK3J9QPiY9yRH
        uduQnYM0zikti1mCdzX5+fc=
X-Google-Smtp-Source: ACHHUZ4gwo6kHA7MJ+HM5oTO2Vi7xTZ8RW4693y0tK8OmSBoiP3YJ6/wNOeC+7NfEEjhZUC5Q5wcNg==
X-Received: by 2002:a05:600c:21c7:b0:3f6:11cb:4926 with SMTP id x7-20020a05600c21c700b003f611cb4926mr288758wmj.22.1686296839703;
        Fri, 09 Jun 2023 00:47:19 -0700 (PDT)
Received: from localhost.localdomain (bba-2-50-150-163.alshamil.net.ae. [2.50.150.163])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe30a000000b00300aee6c9cesm3693602wrj.20.2023.06.09.00.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:47:19 -0700 (PDT)
From:   Yongsheng Yang <iyysheng@gmail.com>
To:     linux@roeck-us.net
Cc:     bagasdotme@gmail.com, corbet@lwn.net, iyysheng@gmail.com,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/hwmon: Fix description of devm_hwmon_device_unregister
Date:   Fri,  9 Jun 2023 11:47:04 +0400
Message-ID: <20230609074704.1259-1-iyysheng@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
In-Reply-To: <e1fcbb8d-c9b3-868e-8053-6ebc33a3e66a@roeck-us.net>
References: <e1fcbb8d-c9b3-868e-8053-6ebc33a3e66a@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 6/8/23 18:31, Bagas Sanjaya wrote:
> > On Fri, Jun 09, 2023 at 02:42:30AM +0400, YYang wrote:
> >> From: YYang <iyysheng@gmai.com>
> >>
> >> Use devm_hwmon_device_register_with_info to replace
> >> hwmon_device_register_with_info in description of
> >> devm_hwmon_device_unregister.
> >>
> >> Signed-off-by: YYang <iyysheng@gmai.com>
> > 
> > Is your SoB address gmail one (sounds typo here)?
> > 
> 
> Looks like it. YYang - please resubmit with correct SoB.
> 
> Thanks,
> Guenter

Sorry for my mistake, I fixed the misspelling. Will post the updated version.

Thanks

Yongsheng
