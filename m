Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8170F6D17D4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCaGwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCaGwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:52:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5FE1A449
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:52:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so22405255pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680245557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbDWzZeJfLQK7RD7XE5y+qJ0xX1vHzacok5EfQJ98yI=;
        b=mOLK2yZxZK6G7HZe/KTvq8dTFjTcpCJjilfy/4qdnBMaFrQuNkTwLnh0PExWTMAdkh
         9D0WoEhAmf0BIrFqXT7WbNY9NNYVRDDcb7GmeesDwJqxmLVv85jK14Z/6DOQ32uzPUnI
         UAW2omAZgucdh3+3wvFBJ/vi++6LXQuzBOu+ZLuPKbu7VtnUybPnqOvOo+OcS8nTzF99
         wZshpImXAixj7S257lZpEq9htYT60BKkkT4woafOGq5MI52tSs/QqBl7CfEBqCNd46Qv
         nCQadqJqJ5lwNmM6QvFwWC9fAMLpjSPjJOIPxV6Zb2G9djXrIokhcdTw63MLX0ajTA6g
         sNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680245557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbDWzZeJfLQK7RD7XE5y+qJ0xX1vHzacok5EfQJ98yI=;
        b=gGe9HYgkt0PLSpGp2kioVLP/yzRE8Bwe9h/Z1CZOaIRD1/1f/if5rS53DuHUOoiUIf
         h8SlYez/Az0JIBEvqqh4MxMnlxELNgAW1Soc+fj6RKrFQe1N4HWB6ioWTwpNIdWRDWrW
         KX1lcikIWwVZwyLokIlkoOsp/SZBy22SdQLvM0bzbDNds2lcv/QQp9WsIJ4tFjcDaEo6
         NfSgpaYg4A5Ypr+YfbiIx1ESpPShh5wg5u72/Qkct29DEFiyl5ZQixt3mL8ZLN7V9hZS
         pcou7DmG1XRK3eM5m8XiiLoMo7fnH5Ew7ABgUxnW0Ta119AhPpHfgRwy5QRGaE+zh3cx
         ASpg==
X-Gm-Message-State: AAQBX9eIFsCjKA6mvJQn3diq622UymxPwDNfNq3u+Bfo/T7+1Q65NEdb
        04IhziGS6OfspD/kpJhyuHwdVqXHD9I=
X-Google-Smtp-Source: AKy350aalS9c8kO1V87B28++Z7kKjFTJ38PPIKG6Lhd1Jw1yjzpnuUkqFRkreLkt9ViEdCocowjGbA==
X-Received: by 2002:a17:902:cad1:b0:19e:e39b:6d90 with SMTP id y17-20020a170902cad100b0019ee39b6d90mr21061326pld.25.1680245557250;
        Thu, 30 Mar 2023 23:52:37 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001a1ed2fce9asm781989plb.235.2023.03.30.23.52.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Mar 2023 23:52:37 -0700 (PDT)
Date:   Fri, 31 Mar 2023 14:59:28 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LMKL <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH v2] erofs: tidy up EROFS on-disk naming
Message-ID: <20230331145928.00002cc0.zbestahu@gmail.com>
In-Reply-To: <20230331063149.25611-1-hsiangkao@linux.alibaba.com>
References: <20230329054935.78763-1-hsiangkao@linux.alibaba.com>
        <20230331063149.25611-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 14:31:49 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

>  - Get rid of all "vle" (variable-length extents) expressions
>    since they only expand overall name lengths unnecessarily;
>  - Rename COMPRESSION_LEGACY to COMPRESSED_FULL;
>  - Move on-disk directory definitions ahead of compression;
>  - Drop unused extended attribute definitions;
>  - Move inode ondisk union `i_u` out as `union erofs_inode_i_u`.
> 
> No actual logical change.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
