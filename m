Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1E5E9167
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 09:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiIYHTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 03:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIYHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 03:19:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F9DBC;
        Sun, 25 Sep 2022 00:19:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so3946243pgs.3;
        Sun, 25 Sep 2022 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JhgeFXBwEssJLCEu3HGm6m9iF2diEh9TDrujALeUOj0=;
        b=QtcLwuge3UideCQ5YgkWRxWwqZ8qJ0Mh6NH3/rBN/BfqBaNwFI8dR30h744EHBieXU
         0ceRDcGbVnBRq2eQ5S2HNTahi63SNB3LLynfnyJUSfOezvy3bndJAeaW9NQLKBXiQVPI
         Fv97ksNXiGIJneFVb7YP8U/EbnAhhVPBX2AtOZrSu6cPPXNs41pobN0tf4feFzEt+2Di
         9qRyFwTritv6dUuU3u4C2Chxo8StKgfj5Y6D6pSSiX8ng88BsauC0GXttsIlDFp3SyVp
         /LCWz34KXLQViTd/P0OfRMqdujScZEHJwuJAi/beXCf/QynyzJOpD/UCdbenaThD13XG
         /X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JhgeFXBwEssJLCEu3HGm6m9iF2diEh9TDrujALeUOj0=;
        b=zNOnqDZcyPm2342nLOsH81Afa3Mm5o1Fkq/Mc9/vGaukxvsU1wMbb60rkdjMQbqyrj
         2gAHFr51vZ38+cXdIcXmw6dL/C6kWOW9nccmT+wC2nBGQdyxTdGOu39+Pl3JevhBh2D3
         TZMJ4Sd6/zOs2lV+WoGE28QUaYie7SB0sqFZZuLVzaCBQKc18ob5lzbKYvfCVZ92fAEc
         MdAo3IRpx5I2HQcT58HeKDt0K4t1FtQCedphY67N3KG9Sp3ELmFUOpv1Ea6DcM17e1QJ
         ZyMwx1ZLI3UFxJr0hPx0QSQvLvbQv+CDy3BhvVyx+kcGXLPxeUhFWsl3arKmxdzZRpd8
         WwQA==
X-Gm-Message-State: ACrzQf1R/62p+MzQsUgWE2vqXAGX2KX3n933dkI0rk+aMT9mSVBkya9b
        8yVet9GGT7YAk5J+fqpSdkSBzqvcoi0=
X-Google-Smtp-Source: AMsMyM7FIEzMCBxaERbb4XhPgMfNOMmA6avqb4RDV5vMVMJdho1fH+S+Ma/vQt+ikrc8A5I+oINIsA==
X-Received: by 2002:a63:5141:0:b0:43c:1471:7eb5 with SMTP id r1-20020a635141000000b0043c14717eb5mr13316353pgl.587.1664090371023;
        Sun, 25 Sep 2022 00:19:31 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:37c:3916:9a45:14cc])
        by smtp.gmail.com with ESMTPSA id i8-20020a1709026ac800b00176a579fae8sm8710757plt.210.2022.09.25.00.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 00:19:30 -0700 (PDT)
Date:   Sun, 25 Sep 2022 00:19:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: joydev - Fix comment typo
Message-ID: <YzAA/wmrF4VxjLE2@google.com>
References: <20220804120800.60415-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804120800.60415-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:08:00PM +0800, Jason Wang wrote:
> The double `from' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Applied, thank you.

-- 
Dmitry
