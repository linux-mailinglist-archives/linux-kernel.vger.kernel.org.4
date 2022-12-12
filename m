Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026CC64A778
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiLLSru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiLLSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:46:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25787E4C;
        Mon, 12 Dec 2022 10:46:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t17so708411pjo.3;
        Mon, 12 Dec 2022 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2FoaTkFR172ODNwxywDb3/dtAhikbK9eu/N7ap6ZAA=;
        b=mwjVxEAAQu4acwY/E5dV1V/PTmZZk/WWngUyGKpXL8jNtgP6uTIyJk8oM7GKW8ha+g
         RE7iMfdp7zKu3Dhn8FhcLyLfUc/Ym6m1wFfvG5ZF1GawGssphXoPXO1g/cqU/wOqd8Qd
         uAmKesoo27osTsjNntW80/ziUoBurHMK9+ayaEZ8PO2cKJJ4yjsDLonfoxTOKJfStppi
         Bn4daYKwxi+ytxSuj+Pp/M+p4vWY+uOs3TEgKDeeiQobbSltDLYiqpXOU2Mq1BioN2fQ
         rgtzQeJDleBWVMO4EW68tcnizGHg6gWuLYxtyxqRE7W08xRkjl4vIPy+szBQKZXRTNPl
         e85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2FoaTkFR172ODNwxywDb3/dtAhikbK9eu/N7ap6ZAA=;
        b=s6wiXwXj3cvTdXqYKN57tfHYb8egKeO7HcxLE3aZi0oF6ZYTT1zc7LpBjnjqIdropV
         sSVHecVdopwVC2m+EYnVFSfnUIppO0FPew5SnfGYM7nfKP0E596zLPrwU5MjkOxSG1s+
         Qr5p+Vc86XweGt/s+6s1RwTe/6P+/Re11f6nfwHbhy7jrDFFcqe3p9LlKft6cOKek2+Y
         JQRSzmPJolaIHzBpZ1jx57hohUVl96BA9T8EtfxCfUg9MfGPbryNAJue9K06HfYmvkiD
         /kct5/gsa9nOVjklbKWv0rsue/a537DUSAYjr0nbDftF7ugbtB3xREHYeSuMG4hDTtDY
         e/eQ==
X-Gm-Message-State: ANoB5pnuJFQZFT30mDFqSx9tCDRDnX1rNfmDf8RRcpQyRUUCS2ifQitB
        84p5k1zapwQDsEJ+lgn65oo=
X-Google-Smtp-Source: AA0mqf7e98PLqwEtjfJbPaQ2iJFyvQXbtl5YcWVeqewHfDZdkTh0+Ve7wssNPlT0JtWymR4LDzKYcw==
X-Received: by 2002:a05:6a21:e311:b0:ac:9d6b:321a with SMTP id cb17-20020a056a21e31100b000ac9d6b321amr24540122pzc.33.1670870776446;
        Mon, 12 Dec 2022 10:46:16 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:77a6:a092:fc6e:38d3])
        by smtp.gmail.com with ESMTPSA id h23-20020aa796d7000000b0056b8181861esm6338531pfq.19.2022.12.12.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:46:15 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:46:12 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Allen Ballway <ballway@chromium.org>
Cc:     dtor@chromium.org, benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rydberg@bitmath.org
Subject: Re: [PATCH v2] HID: multitouch: Add quirks for flipped axes
Message-ID: <Y5d29JwIxku9ubVb@google.com>
References: <CAE_wzQ-WrjOgSADCn4v80ESwicOFif_Trn3Wrq=5toy2+y+q=g@mail.gmail.com>
 <20221208165145.1.I69657e84c0606b2e5ccfa9fedbf42b7676a1e129@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208165145.1.I69657e84c0606b2e5ccfa9fedbf42b7676a1e129@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 04:58:36PM +0000, Allen Ballway wrote:
> Certain touchscreen devices, such as the ELAN9034, are oriented
> incorrectly and report touches on opposite points on the X and Y axes.
> For example, a 100x200 screen touched at (10,20) would report (90, 180)
> and vice versa.
> 
> This is fixed by adding device quirks to transform the touch points
> into the correct spaces, from X -> MAX(X) - X, and Y -> MAX(Y) - Y.
> 
> Signed-off-by: Allen Ballway <ballway@chromium.org>
> ---
> V1 -> V2: Address review comments, change to use DMI match. Confirmed
> MT_TOOL_X/Y require transformation and update orientation based on
> flipped axes.

I think you might need to push the DMI match into i2c-hid driver, and
bubble the quirks up here, otherwise if you connect a 2nd USB
touchscreen to such a system will also result in the quirk being applied
to it as far as I understand. In i2c-hid you can make a fine-grained
match on vendor/product and system to limit the quirk to hopefully the
right peripheral.

Thanks.

-- 
Dmitry
