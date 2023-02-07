Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA868E252
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBGUzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjBGUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:55:17 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F253FF2F;
        Tue,  7 Feb 2023 12:54:54 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x10so11335722qtr.2;
        Tue, 07 Feb 2023 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJYwQvo65YV42CcV67j6ThqJrL2j7vs+//jJJBY1lJU=;
        b=llA8jH1JKpr+bAusRJRIFeZ/Iqv4GXI5iUR1BlNEKrmRbiDGHQ3cLLgV9tp7uILLIa
         QdJLlqqYCPybhOpSlLdM0z7SlLvNgbC92+KL73sz+S9zNlQXbpwwyUeIx0GjdtzWUbif
         6vN+eVYyS6bHiyqYyKB85dWaZN7wTgOPS/a/31naUxzDQtxrlDLj3Ske7AQmlJP/H42Y
         xCRPkBBy9G+GKOZo7+8p0C+r2VkaLI8OQINhp1P+4V7RPfenBVMskigk1NO8zrlNX8sD
         xZ7XKWHRuSsW+480scXYEUrry54oxOHjGc2bGflXgYB0civZslT8ehKQKkzMXU0WhFUq
         SkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJYwQvo65YV42CcV67j6ThqJrL2j7vs+//jJJBY1lJU=;
        b=U9VBxJMwTZfd/tMQCu787fhYmFMTazHM5M4nz444hXTsCW9PuXNDptyNIGDFxblCXr
         eOng8FbQshq07IlkFSVlo6K2loOzBV5R7kkSZ21iqS+REejVYICmgJawLISl3wjY6w5X
         xwrryYPI0sW4TCbHGdnF5NoEGWS7NpaNN23ZlJ24GqG2/M6CG5LOqsTOCdR/WwnF8qKG
         lRDXClI7KxZ/g2sQbQn92TByYoQUQUilDlr7NDcrWFTqJvLNGKsHQffRn491Ifhw9uAP
         Hn7WbF8wvNcdd9vW+OiSe0BCI4dwA6OodfJkrmwe6UCK/FwPJB7z+QFPa6Z8ScYJXVoa
         bjlQ==
X-Gm-Message-State: AO0yUKX49YJ6FTml82hFiXRFMCliseFjq1b0w+xpDb682c9TcD0a7J50
        z5bKZF6gx+wT/EbieO4kNRE=
X-Google-Smtp-Source: AK7set8mDwYpo/iKZ6AafvA0mQowqngfNnOUwxaaIcqcw7DFfC/t2H08eg7u6sWHCgAipUZOpGfzeg==
X-Received: by 2002:a05:622a:1393:b0:3b6:30b6:b894 with SMTP id o19-20020a05622a139300b003b630b6b894mr6817929qtk.20.1675803293183;
        Tue, 07 Feb 2023 12:54:53 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q18-20020ae9e412000000b0071f636c108bsm10097714qkc.73.2023.02.07.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:54:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2678027C0054;
        Tue,  7 Feb 2023 15:54:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 07 Feb 2023 15:54:52 -0500
X-ME-Sender: <xms:m7riY-mxHaW4HQA5Uz3C2ggGAftD8JgtA3Pw_aKmVQi7C-p343d1RA>
    <xme:m7riY10yPlR8dNxSco9rKxZh_cax1enBHppL0DnldrHl_sIZ67I1NvyBFewbobd07
    TO8STkFHkafManvVg>
X-ME-Received: <xmr:m7riY8pX18rbbV0OcA5DxcfLwraFSFaWbh8LktzN0DGea1_FbNjvEaRePtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:m7riYylJqzWYGfTEtzFcwCy1J4etyIiPpjl9wMqs06IwgKcq7TaSMA>
    <xmx:m7riY83AuPl60Ug5K69YxE0nSBpXgI190i7ExW1043uxh3qyRfdkyg>
    <xmx:m7riY5vhxFS7RIhMjLb8mzpAEsOSavC7sRh3_tyCkGFHDWC8kZux5w>
    <xmx:m7riY31y-VF8J1_T_Zw8oRFFozhZTjZboECSQwudTo1BlRnq3L5kvQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 15:54:51 -0500 (EST)
Date:   Tue, 7 Feb 2023 12:54:33 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for {Unique,}Arc
Message-ID: <Y+K6iextaWKdqtHP@boqun-archlinux>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-2-boqun.feng@gmail.com>
 <CQCMHZWN9GKV.20T08UNZV7FTJ@vincent-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CQCMHZWN9GKV.20T08UNZV7FTJ@vincent-arch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:45:59PM +0000, Vincenzo Palazzo wrote:
> > This allows printing the inner data of `Arc` and its friends if the
> > inner data implements `Display` or `Debug`. It's useful for logging and
> > debugging purpose.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> > ---
> With this review I will override my previous one, because it 
> contains a typo inside the Reviewed-by.
> 
> Sorry about that!
> 

No worries.

> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Thanks!

Regards,
Boqun
