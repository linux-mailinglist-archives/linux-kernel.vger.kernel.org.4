Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A152570E839
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbjEWV6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:58:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B41BF;
        Tue, 23 May 2023 14:58:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so35398b3a.2;
        Tue, 23 May 2023 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684879100; x=1687471100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luGFiBCmA9lpLLhi7oUt0xIbuMttQH5Ausy1dExaPMw=;
        b=F8/0+34K6um1siiPTE8Gi9gf2r0302AS4sPgav9S8ex4nDcClcNrDuULKtcZmfDjNe
         u5SYDw628h26yJeBDREWUWivr2jCqGdBAfdPFSBQ5Y33sEK6/8wW6P4LVeOsddEjVLBK
         Ve3Oz8q7t4WtWTg4sSFVNNy6o8myscNQcLm7dCVE9VW8ZiAHkrxiFdNBLveCW6i/sUGv
         Ff0WfyJEl8OlaTmPvqCrkyZsKpUmv/p1ppvDrl1rveloodSEj81Q5XnaUfu6Ctz0tOTx
         CYKN688r7BCZOXtXUGYZCUCrmfmyK7kq6oMW+AVi2ITAjErnJDY81Cvb43zeloNYmH9C
         JF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684879100; x=1687471100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luGFiBCmA9lpLLhi7oUt0xIbuMttQH5Ausy1dExaPMw=;
        b=U3/58W2fda8xFemIzAQnVsVBNfjSWWX2/wW9dvGql+L0CnWEvgfQtPf9gtczmz5ocE
         iU/2tpywgzCnGp4Gm/WgU6BF/c/Jt1UiduT+Msv+56L5+i8bd8VvXeNwgh4M0tkvVswG
         nrb+bLR51tJvqirBcLw/m4Rf6njCo1Ux/JS8oGyAFMP7z/QZJimjV5lHj62eRNxwJVZ8
         if6me+QN0v0GPYf/wTOxkBBEx/7OcZvJS/KK+hklBoIcHYdVnv9EwwvFQMST3I4P+NTF
         5w35ay1B/eoFD65x32zBnyuh4pUhYdUE4pUY/WX1/Frw1F6+Gm54676WHh7o6mAJ0ak4
         pv7A==
X-Gm-Message-State: AC+VfDz7tSmcXbVBPInb14/ICNUVaaqYYLa8UVshFE73sBONfr4cWikm
        QbGR9pd1ehfTbjIJXGTYq8g=
X-Google-Smtp-Source: ACHHUZ5WYpsOqZ+clEEIIg5dGNbsJXwwYmsVxjI0uT11Sh84qJxwLmj6u3ehWM7xjsUA2oBCz63zLQ==
X-Received: by 2002:a05:6a00:218b:b0:643:9ca:3c7d with SMTP id h11-20020a056a00218b00b0064309ca3c7dmr660812pfi.4.1684879100115;
        Tue, 23 May 2023 14:58:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b0064d3446df87sm6197846pfo.183.2023.05.23.14.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:58:19 -0700 (PDT)
Date:   Tue, 23 May 2023 14:58:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     eballetb@redhat.com, javierm@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dana Elfassy <dangel101@gmail.com>
Subject: Re: [PATCH v3] Input: tests: add test to cover all
 input_grab_device() function
Message-ID: <ZG02+KBnqwBEv8Am@google.com>
References: <20230522215514.722564-1-dangel101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522215514.722564-1-dangel101@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:55:14AM +0300, Dana Elfassy wrote:
> Currently input_grab_device() isn't covered by any tests
> Thus, adding a test to cover the cases:
> 1. The device is grabbed successfully
> 2. Trying to grab a device that is already grabbed by another input
>    handle
> 
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thank you.

-- 
Dmitry
