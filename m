Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3F6633AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjAIWEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjAIWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:04:46 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B813F1E;
        Mon,  9 Jan 2023 14:04:45 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-14ffd3c5b15so10304206fac.3;
        Mon, 09 Jan 2023 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ndmvoomVU+29u1ZplaN4voxmDKd24l7mMFDrJXy3RT4=;
        b=RVxsBWLZxfqWIdO8wi4okCKWVWyIFXm0cs9yDdVBrOFDLdRzZi9FygxHpQ7w8dH1aU
         EtL6x9/dZoF8TuWpjFwhwDkOX/XPwgRm1dCaIekdMXrCcFrutryrAAgfyTAbILIdg+xK
         HpZAOe3f4yv9EJwjrhlPTm2AbJYDHNsY90jS3HjiklAyhn4usieuwNQncIaNQRYMYUQw
         VtfUWw9Q2grWNWJxmaBfbScROuXlt0l0QluL27BjIEM12eMEmK+1O7oNvQWKKnSULOCr
         36xvAxRQRg8IKZfPKor3p7DWAHowtwM+W0/zG0uN/6v5ZE/kXtsf51LIV/Sup+BR3HZf
         5BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndmvoomVU+29u1ZplaN4voxmDKd24l7mMFDrJXy3RT4=;
        b=vBZ+ZVXZhNSVnSgYD6Z2mbb2vQLQh7CP9hbLOLsbUBI7FgzqXrDKWXd1I3qrE69tcd
         RXO/xoAzHm+uj3k4ylBKaqIyFN2opozwrK2OdDP7wsq4LtWzThOA+pi+mNVwJCCULcVQ
         FkT565zhf9HmoR36wWtEI2OmKmsaRVNMpV0Rq/19uzy5SpVyZoLrflm30WlJrAgzUEWF
         u0D5c8lcwvJ1UcpefVmUkjyGpGeRaiIfLlNT2ObWld1aD7NXaFNtbZG0GhkCtTGo4j0B
         WJJIw0ZCJo3KzXcRkltLX8+i+3vvbtwxB/nV//85JegPKjVOHcaDPx7hcgACzmzLjvZs
         RCNw==
X-Gm-Message-State: AFqh2kpUuaWU+p3mNHgQLg0kdeCGjJM+h0AmBwNqD2qMFaw/lcxPG3P+
        1VKjVhCElyeQWX4hzkwAOfsxW2keYwivBIyOXDXTcTVU
X-Google-Smtp-Source: AMrXdXucrU52D8N4+lb1AlZyET/GL897KgmxPijiJi0bNMVIpWp7KHyICWiPeOTg6BKXmuCxYjxC7bqpSx6DEM2mzzs=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr5593342oaq.46.1673301884648; Mon, 09
 Jan 2023 14:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20230110085858.7667eef9@canb.auug.org.au>
In-Reply-To: <20230110085858.7667eef9@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Jan 2023 17:04:33 -0500
Message-ID: <CADnq5_NTwqtODh52zzTgGs5HvV+Xw232dwuSVvvehgqzQiyUkg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 4:59 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   d6baa536dd7c ("drm/amd: Use `amdgpu_ucode_request` helper for SDMA")
>
> is missing a Signed-off-by from its committer.

Fixed.  Thanks.

Alex
