Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349C5BD884
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiISX5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiISX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:57:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC934E600
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663631819; x=1695167819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b0T0vZZkQKS2ASzkRyQjA/Ex8HApxh/6xQcC/blyp/g=;
  b=V04dgxEvasCNgxGxQH7tg++srJ4kUrREz0lgtnnsKk+kgbS4QO51+73Q
   Wk2DSWOCBu2M0xVEgmPZcHT/es+h3+IfXCnLtqXAKQsiKWtwJDszvDF/4
   9mRJq0Py4p1CRjQPHeobs2kriAE6MiYB6ybKDW/srvddaVOEsFFaDO0s2
   OKwcomMT1SnJ8thyAtpqPiSwGhUge6j7L2kOUgu2I835vvx1svh8GbE7w
   zmGGJ/gzR8QmkKwZ565MnHNsHxMubhsdWA3ylZcsFvlGOixMPkAyCAAcj
   qm6JsSkeThvxSVuOzISH9Qyinf/5XB/5o9cjinDFO9tKLlp34Q0V/fIzr
   g==;
X-IronPort-AV: E=Sophos;i="5.93,329,1654531200"; 
   d="scan'208";a="316037880"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 07:56:57 +0800
IronPort-SDR: tHCZ9QeN0Yiwqdk/h5xyP/UD0PbmzJKFDw69bfGxW2FKGXqHOykHvWxXyWvlrrSMmawpA9BAWx
 Y/eW3avle0Yw/xBQrUFuWNkOLT4kuNKJ+N/ev51tOeUngkyCWyGcaCLRpeOaYcRY4UBQc9R8KY
 EkYj0d6MSPB5C5/8ih4ADxmRDegSBktSDKszneemKqL6TdNt/X6POgJgB7y/O4xTw8YapyPdpg
 IIluv2NKZqXtjDN5RdliC96fQgQ1eAyakl5k8uDJ1nMDxco71jG5LC/nq+CJYYK1c+DIoc+oSJ
 WPaP9UlE9DeeUCdHdv7mB1p4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 16:11:35 -0700
IronPort-SDR: 3tuo8G642UKo4mlr6Co3nK2uqcak4LsH2naL90GgWbuZdNB+0AdMGyTB56AiEIG07wP5yLXKED
 jmXBTGJhv+k2i1gDKK7ns9h6T2h5k4i63UiGVNfs99bp4VRTuFK+IqcFSV1QTvwfCGNVej9H/o
 /legVZIdItbPLjWK8d8adnQrqj0xABkZSgYm7f9XqKK6Vkk/HD9ExfXuwD0Wo7qtY6VFwzHAOE
 +2LM++bb0Z8DYJv2CA4baCc/svQnybTY3pZtG/ggtBGSnmNAABCyAHWU1WrtTBYd+Divi7CvGt
 rTM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 16:56:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MWhRY2ylHz1RwqL
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:56:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663631817; x=1666223818; bh=b0T0vZZkQKS2ASzkRyQjA/Ex8HApxh/6xQc
        C/blyp/g=; b=YiT/VI9112XRTtC4zWjamLi9iuNQdFZlNouAAj3eioDJCrJk3sn
        0bFG6npMEXjmiMnhBISE4/3jwGQW+SENMKkBWmsyjRxB0NGCZuYgU7jqMyBnZ2Fp
        RDFK3pXkVxAb7CD6+9Eqp6ryQeMUKl0nA9joUY0pP+YjZaZJ/Wyb+BviA2fVf4e+
        2OUvKqktLvIr+PehVmIbX1pz9oHkayfiO468j49/a1dmxrQpmyJdiKDIJlPmLfOQ
        6VeIQPobaw4Uyo7oQm20Ne1XlDVnTAC9POzxB9lIL/2reBOrm9Uy3PdUAkQgW7cF
        ZFlEW0h2V6Jt80la2jJiBOMmgt/ny27bqag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6-GLyji1C-jR for <linux-kernel@vger.kernel.org>;
        Mon, 19 Sep 2022 16:56:57 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MWhRW5Cjbz1RvLy;
        Mon, 19 Sep 2022 16:56:55 -0700 (PDT)
Message-ID: <6f9b5fd7-8a8a-619e-f758-216cadd8ea08@opensource.wdc.com>
Date:   Tue, 20 Sep 2022 08:56:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: linux-next: build warning after merge of the libata tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220919124034.58670a27@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220919124034.58670a27@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 11:40, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the libata tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/ata/ahci_st.c: In function 'st_ahci_probe':
> drivers/ata/ahci_st.c:147:24: warning: unused variable 'dev' [-Wunused-variable]
>   147 |         struct device *dev = &pdev->dev;
>       |                        ^~~
> 
> Introduced by commit
> 
>   3f74cd046fbe ("ata: libahci_platform: Parse ports-implemented property in resources getter")
> 

I pushed a fix for this. I also added a dependency on COMPILE_TEST for
this driver to avoid a repeat in the future.

Thanks.

-- 
Damien Le Moal
Western Digital Research

