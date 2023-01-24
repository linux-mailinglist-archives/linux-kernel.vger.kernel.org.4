Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAEE678F37
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 05:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjAXES5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 23:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXESy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:18:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54307305F4;
        Mon, 23 Jan 2023 20:18:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e3so12639645wru.13;
        Mon, 23 Jan 2023 20:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4pDbcj74Wbcg/58B56E40yhsIDYcgblc7WuBVkYMZ4=;
        b=eEJh06r4R2daIAfn1xURfmMwc6qN973syj6XOdabRBcw6azMQ5FfxwuCzR4zeVqkA8
         3Wi+XkZG1BjPit6NU6Rm6W7jZboN0MVD9PJIIoCSevZZcf1Q6IvGUrJorvT+RhDbMs95
         7sin78GW3njueM3IwlL9PByEEjeRW/XTEnmrbxtxwAsvYlPtsgSuI21VVKkjxvwpJIsx
         Kat8B1UGTgTxBeMcBsUjbDE51ISlEc74rbNYGTluOJHgVfiZaOKat5aT/OjRrmDFF6EW
         VQuNdyrHBWhMQ9Ma2gNd1plgI94qxscklnpCkCu4V8e6x91JreoOQzBuRkJMjrXAJWtl
         mrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4pDbcj74Wbcg/58B56E40yhsIDYcgblc7WuBVkYMZ4=;
        b=L4QdmEu8xYcLiZP2kPgYcR3VIf6PqN2XzPY+UYPny4v0tqQBlTKBcbbfjSKhQUhg0Q
         5enli8RMgO+AiVu5OqMK1IF7HuoEExj2VDqTYJo5Ij+rA0pC6FEuOdZU/DxbC42RZcn4
         0kCFny+Jtl8nPVaaBdoEOHq8tApO50g9wI2720zTQHX3Fd4k6ll9iQRvXLz3QI8CoSjz
         JFiD6oA5qJntxJMDLDzWJsZC8KwQk8ouqcdZJ9u99jQIxeUKRuTukaxIq6YA9sLi5xwf
         9hWUdiDFG50UaSQKrc1VoP6G4Sh0Y+9OIbpWMcMYIcQrrXI9zFAXAXA5985GvEOUw8s3
         bVxw==
X-Gm-Message-State: AFqh2kqj8fq+OvKRHqFmGXuQpk76NESprJQj9gc1kC/njzZpRPgs8Sv8
        yh781lagmJeX2V1z7QB93fSy0m3nELy+wA==
X-Google-Smtp-Source: AMrXdXuU+RiiQVIsOLUuAcUY0r7W+UMek2Ck+OomzTAKLbAZyP7BRoLqhtHT6QAV56t8J/dUfiLDzQ==
X-Received: by 2002:a05:6000:603:b0:26b:e7e1:ad03 with SMTP id bn3-20020a056000060300b0026be7e1ad03mr26304968wrb.55.1674533930714;
        Mon, 23 Jan 2023 20:18:50 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bv17-20020a0560001f1100b002be2f18938csm823273wrb.41.2023.01.23.20.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 20:18:50 -0800 (PST)
Date:   Tue, 24 Jan 2023 07:18:46 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Brent Pappas <bpappas@pappasbrent.com>, slongerbeam@gmail.com,
        festevam@gmail.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, mchehab@kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: imx: imx-media-fim: Replace macro icap_enabled()
 with function
Message-ID: <Y89cJvIYtg9fkczb@kadam>
References: <20230123191714.22430-1-bpappas@pappasbrent.com>
 <20230123215105.fbfzxueegtnbu4ym@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123215105.fbfzxueegtnbu4ym@pengutronix.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:51:05PM +0100, Marco Felsch wrote:
> > -#define icap_enabled(fim) ((fim)->icap_flags != IRQ_TYPE_NONE)
> > +static bool icap_enabled(struct imx_media_fim *fim)
> > +{
> > +	return fim->icap_flags != IRQ_TYPE_NONE;
> > +}
> 
> Nit: I would make it inline but recent compiler may do the job for us.
> 

Yeah.  These days we tend to not make things inline.

regards,
dan carpenter

> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Regards,
>   Marco

