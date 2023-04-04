Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5436D65F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjDDOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjDDOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:55:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589A4206
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:54:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v1so33124940wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680620094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxVZBWawZsgff68dcMYx7EZEDg4tJjxtTauJ+h1TXRw=;
        b=TkxqWl9klIEOCOfWOemzX+9mYCigI5Qb/+b4sSdi06yak7KhwpuHbVkiaED6uLMr2y
         AvX/a24uJTGxsC9P1P4WTN4IkywNIyE7AB1yVdK6QeV97TZVgsn501RxovedtBPI9L0R
         l9DtQUQEQdG6K47ub43DOmjiXaLcg2aRGliT/TTN+sdvbY2qDFfm1qELG9SVyDG/W8mI
         O7m3shDl+s+4fCRAyrmNfCw++oz9ppZKrdTV4iBH3kIhcgZChAT4sT0S03EpFuaNzjVI
         G8aNo0Rw9epsli9jC+WYZhs705LVcMuDD5eUjirs4OLk2ouaK3sU+nodNMTNbJDOoQJv
         mMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxVZBWawZsgff68dcMYx7EZEDg4tJjxtTauJ+h1TXRw=;
        b=VDpSkCQsH83klTSKvHK7qqGYdh6ThHAwie1idQeoM3sU485Zsxuo8rAawZoro6kJtJ
         3upskyO05I/iu8WSOBjGBpK9q0ub/4JWAS52yAxMjgcb7+L/EXO3qqTG6aAvynPrBWO+
         pBd8t6Ef9d2F6meMoJx6XA5MlM2CNe/pTEK/G9QHxRVkriy86gL+poJNBuoe3TssuJAN
         cShfxJaSRRNoNtbZ5TtPNp+CpdmXGNcZ2/7eBacIAhES8el+D/+hgd+0baocSRW+MR0H
         P4WS/xBL6lhbTRLuYW4CWGPcDb/Bk7AQGQ1Y3t5RXlxlZeok+CBk+50TxTBGKQj7nn+9
         CuOw==
X-Gm-Message-State: AAQBX9ep8EvfY/zAaDSLcYmEAR8dNYVR+uG5diREm9i4C0Ka9YwUlHfP
        Ao3zC/xzOTMVUgld8lqCCg==
X-Google-Smtp-Source: AKy350YeLgojUroFJr5j/Mdy9rW7Vu+LAacdpi1Q6ezM6WAnRFIY7tiRPi596i/G7MtdOJ8TDzDZSA==
X-Received: by 2002:a5d:4106:0:b0:2cf:e8b2:4f76 with SMTP id l6-20020a5d4106000000b002cfe8b24f76mr1819795wrp.66.1680620093714;
        Tue, 04 Apr 2023 07:54:53 -0700 (PDT)
Received: from p183 ([46.53.250.185])
        by smtp.gmail.com with ESMTPSA id o5-20020adfcf05000000b002c592535839sm12483988wrj.17.2023.04.04.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:54:52 -0700 (PDT)
Date:   Tue, 4 Apr 2023 17:54:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: implement streq()
Message-ID: <db6ce106-a5fc-4742-a59e-ccbd39dfd69d@p183>
References: <4b595ab9-238c-43a5-aba0-be5d6afc0f87@p183>
 <20230403141641.6ace0d85fd48fbed5c02d7ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403141641.6ace0d85fd48fbed5c02d7ef@linux-foundation.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 02:16:41PM -0700, Andrew Morton wrote:
> On Sat, 1 Apr 2023 20:48:05 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Most of the time strcmp() is being used, strings are checked for equality.
> > Add wrapper to relay such intent (it is shorter to type, too).
> > 
> > Use
> > 	if (streq(s, "s")) {
> > 	}
> > or
> > 	if (!streq(s, "s")) {
> > 	}
> 
> Gee, do we really want this?  I mean, we all know how strcmp() works,
> don't we?
> 
> I'm thinking it would be better to remove the various cute little
> streq() macros and open-code strcmp(...)==0.

No! It's cool, trust me. Try it out, you'll like it.
We "know" how strcmp() works because C didn't have streq() from
the very beginning.

strcmp() is only for insertion into trees. Half of the time you need
to read to the end of the expression to know if it is check for equality
or inequality. With streq(), you don't.

	stralexey
