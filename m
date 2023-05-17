Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681D706F07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjEQRGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEQRGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:06:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62CA7AAF;
        Wed, 17 May 2023 10:06:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae507af2e5so1931495ad.1;
        Wed, 17 May 2023 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684343204; x=1686935204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=boazAWl36v99eEXuRpQ42/WdUM91p8HdkXonUurVJnE=;
        b=OTVTUiXLiRLSJ0wsvnQZu/w7pzW46Ur56awRS8Z5tcwFDGqRJI6jIt2aBRcat1OLd9
         ycc3xXDZmsOgud2KBY/k+znszxraf2Lz2rfvIW7P2GzgYfl7VRqtNRCyiKL7nt2ylF1i
         EwMIq72bS0fdI1Lvn+OXLYf/ryX8eIp3aZz6ZjDtbA8hBeFioY/QQeHbMcK6dVROzN5v
         IUu+GvIo3HVJfQINFthFi+A6m8FnHX6+zyd1wjqz+NmFQo9YRIr14K2CMm5fbRSXQpg6
         5ZM7eKcvEo2fTGCu7S79dzXeX/jW2DigpgXbejCjAqDE6IF2mGpfWshcLaX5xB3gUU2Y
         matA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684343204; x=1686935204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boazAWl36v99eEXuRpQ42/WdUM91p8HdkXonUurVJnE=;
        b=Idximj60gzbeRujRQ1vHP0OvWjLssA1Ig0m/Xa4c3CNuDlnzBaUBghXBzD9EmtkLcJ
         AQ/PHomVxFwIvpklzW09yeLUplimxslxxZZUbmRbh3qyZQtu+DNj/2SIYhIM4D3toqhI
         ZC1ejgUk+FkxN6oqeIeAyHnHqvf2ce5kdy7SQbrECinT87/PbTvBQUABJVgegWJ+zrYS
         /Ga3YcJCE+Y0tYyY7bkkfsloKj0xkzjZxNz8SDIKve8S3GjMSZ6Jo57vItqEI14C2pcz
         XmCklNAim6xJ1J86gFM/wQnyFpsRqTa75ssGNyh1aPnOPNYNg0DtFFjFPuT4mMuRx1Gy
         YULA==
X-Gm-Message-State: AC+VfDwzXGVIvoMtrHVsPfeOO1t0ZwWd9AqRXHkNssSbDg0wkQC827EI
        BVQTdH/VsvBRZW6m7uOpQuSBYgEO+oc=
X-Google-Smtp-Source: ACHHUZ7q7MqFCnq8IaUlTrUceSrGbeKLqTSMIWuEE+5Yu3af1tProZktDsF9qBnro1VBmfteHNhMpQ==
X-Received: by 2002:a17:902:d2ce:b0:1ac:61ad:d6f2 with SMTP id n14-20020a170902d2ce00b001ac61add6f2mr3791404plc.5.1684343203941;
        Wed, 17 May 2023 10:06:43 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6ecb:b01b:2e2e:6c1])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902db0c00b001adbb8991b3sm14095177plx.89.2023.05.17.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:06:43 -0700 (PDT)
Date:   Wed, 17 May 2023 10:06:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     eballetb@redhat.com, javierm@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dana Elfassy <dangel101@gmail.com>
Subject: Re: [PATCH v2] Input: tests: add test to cover all
 input_grab_device() function
Message-ID: <ZGUJoClUZpL71Jw4@google.com>
References: <20230517153145.513095-1-dangel101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517153145.513095-1-dangel101@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dana,

On Wed, May 17, 2023 at 06:31:45PM +0300, Dana Elfassy wrote:
> Currently input_grab_device() isn't covered by any tests
> Thus, adding a test to cover the cases:
> 1. The device is grabbed successfully
> 2. Trying to grab a device that is already grabbed by another input
>    handle
> 
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> Changes in v2:
> - Use input_put_device() to decrement the refcount increased by get().
> - Remove unnecessary struct input_handle test_handle variable.

So this tests something different than what patch description states.
You are testing that there is no "recursive" grabbing happening (an API
could be designed to allow the same handle grab device several times).
This is a good and useful test, but you do want to also use 2nd separate
handle to see that it gets -EBUSY as well. And ideally we should have
another test verifying that the 2nd handle can successfully grab the
device once the first handle releases it.

Thanks.

-- 
Dmitry
