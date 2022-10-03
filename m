Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2943F5F316D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJCNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJCNlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:41:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE22FC18
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:41:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z23so5496105ejw.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 06:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=87EL5HCbLLc+SMKcWI2SMW0ZJRDyqTkrepU7eacPBXo=;
        b=bROpYd1TRQxhngvEXGNWkS18E+DYiatO48+xhU5QOfEjeAUzEWhgS+cVsrcbnqm8Dr
         Dv5kL210lbVcRyadxC+0GPIMXkX5sITIe9vPhGudkUYQlgMmftFMLXUf1kPtA/FwLU+j
         Th/H3rfNDKQjooAERqLS3MK60PnFsF6+8V5JdN33P+8xZRqgp+Ew7n1n5pwHHVX7v6yk
         7HrSD0zU6JEeoKVjV+QXtGYAqWikdZm4a5qrinZr2F23O94qvgKwAmYbIeiB/W/QDuY3
         doporzl+Jnd4FxCKwY2IQwoZ9hAcB0huW0cgQ1A4W0gcGA+10jOpP3LO6iT1WRKRvqqL
         AGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=87EL5HCbLLc+SMKcWI2SMW0ZJRDyqTkrepU7eacPBXo=;
        b=eIvaYsamQx5Ar6N1baPjWN80xnpJgxWjjFfp8zToxJQb8utU96WJXMYEYeZRp7CD7F
         8WsTAV4YHaOx+prVvY5PKl6A9XvCRsgLQ9mpQ6pybupDwRL7G944+IqaomSBY9LWzmvy
         sjPhK7I1A6+xReUhXpr7PMbFruJO2xF032NZQ66NyAETsXzv4tyJNpbHTJj1dz4vq1y3
         IITvFN3qgEdTvCNf5rf/eMhjQi9PhorK8NKTG2tXgH4y8tIwgahModMaA/ZCSvmkRFPk
         vyhzJXqF/ipr3w5xTcNIFbDpwMhTkIKZagu24GnLuiD2H77J57FMIQJ9VGbIP7Mzd12J
         9s6g==
X-Gm-Message-State: ACrzQf0zAa8nxE7rv0vDnAO5EZnx7xCl0wxcB+C5mGHwJE9gYdqgGoZF
        1wqEDXfDy383BCw4EVkrUVOw69b7fqXN06EUgy0=
X-Google-Smtp-Source: AMsMyM4MtG7MaK01dm5TqTezCp4r6Y+UQZbLaKBt5WcmRnpJkUUeK1WSrB1Om9R9Xzn/SyWXSINPAK3grDK6ThKhPEk=
X-Received: by 2002:a17:906:ef8f:b0:77e:44be:790 with SMTP id
 ze15-20020a170906ef8f00b0077e44be0790mr15082456ejb.409.1664804503195; Mon, 03
 Oct 2022 06:41:43 -0700 (PDT)
MIME-Version: 1.0
Sender: aminamama100284@gmail.com
Received: by 2002:a98:b504:0:b0:186:894d:3107 with HTTP; Mon, 3 Oct 2022
 06:41:42 -0700 (PDT)
From:   Tomani David <davidtomani24@gmail.com>
Date:   Mon, 3 Oct 2022 13:41:42 +0000
X-Google-Sender-Auth: 60x0f43PIqNx_OaJ9fcjR9valF0
Message-ID: <CAPk9rGXnQ703HTUn01nSXG_gfOWfbmCP6dxgr9SNCQjuCV2WRQ@mail.gmail.com>
Subject: Opportunity
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon,

I want to discuss a business with you.


Regards,
Mr. David
