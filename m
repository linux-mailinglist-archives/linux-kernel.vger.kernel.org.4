Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591736B7BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjCMP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjCMP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:29:01 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE3A5CC26;
        Mon, 13 Mar 2023 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFbSGdhzaPiDC5r96NhPQY2pm/QWjeUzy4DJ+DaN/4M=;
 b=ZnnEugj/sS/qGksDdn6ATU1N+sJ5IJ2R96T/gQZWBMiWa5eKNu2sCVMsPURTT7MHdfwdpqDFSAr0TIbDd4ZVrkC3F4e4E4ZU/RtaiLk2q4mjjRpSs2pdIyn/hTLsQytKOw6vupOrQolEdTvikbuzTGF+M+bu+Cc5LRkacKbGw/BlJFmUP0C90iVUfsKnMV/OQV+jKrfhp4cgVLlI5ukDKC3ieQRxs/dqAGwdIh/GxK8f8XprZCIZnJ9zfbfISELyoDjmUZAx8hISd/Fy09+qo9dPvMip7xXBdBHbjk0uWHEg/J6RE5e6AmBxDZ5VxcPdwKoUQx3AmtoJtvyatvoLEQ==
Received: from DB9PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::26) by PR3PR03MB6652.eurprd03.prod.outlook.com
 (2603:10a6:102:5f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 15:28:49 +0000
Received: from DB8EUR05FT055.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::d0) by DB9PR01CA0021.outlook.office365.com
 (2603:10a6:10:1d8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 15:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.86) by
 DB8EUR05FT055.mail.protection.outlook.com (10.233.239.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Mon, 13 Mar 2023 15:28:48 +0000
Received: from outmta (unknown [192.168.82.140])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 7644020080270;
        Mon, 13 Mar 2023 15:28:48 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (unknown [104.47.2.53])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 8F0602008006F;
        Mon, 13 Mar 2023 15:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdSNgZMzaV4g6vEr13op6UnWloyrCmj7mvpZtZSgbEL5dWRrk4UJbaw7pDGkiGa9MqfEnCAzFGCAVBkEHV2WUCt4F6PARcMbzRRGzLt0ewdHXNgZfa/W1sgJRWNRTg+4eTJPgnylqVnDJXXhLbQL+Au9YHNZFDDoOBk9rGCH7rztd/j9a6Mki2fLEcDwNaQIZ8LMqnLl1tW6/jSRHCid98372xUJYEDLyG2Kb7F+i7o8OgOXBXul+fCXoBrXpybQYdi/O9KwuL9sNHtEGpFAVWdMpI8MuuwT6xK76OoKUSe92C/SKq1IfplBeT7I0JOFo+0qqKdCq4gvnpKCEveXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFbSGdhzaPiDC5r96NhPQY2pm/QWjeUzy4DJ+DaN/4M=;
 b=BWdrcy1iEoRQGIkqvd3BHH80Ptw//sR0QyxURuECA1wvHq/FC5S6hpn3ymOeNyBOl1ymbUrlYYA5xb9TYTBahmjsPG+a20pkJRXVlRjGeIkVJ+oUv9RpvmnkVkKctZPjJYQIyHGXO1ZwQqJP7xyspWYJoLVfk+/CmBTvR3e9f+baJR+sqeiqJR69WEowx3hTRVa5F6/wt6XDhLlmBjhVCZlQCReMiiOj32/rwclEWaN+Sc5qBYg6tEhHV+W94p3g1UbYZLgOaDEFD0T4uX+bctNBqu8MfWAByrB4JIOtQiryRa/xsBhpzt6RuWEzHle+dzv0WjACcz9a1VEFejbgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFbSGdhzaPiDC5r96NhPQY2pm/QWjeUzy4DJ+DaN/4M=;
 b=ZnnEugj/sS/qGksDdn6ATU1N+sJ5IJ2R96T/gQZWBMiWa5eKNu2sCVMsPURTT7MHdfwdpqDFSAr0TIbDd4ZVrkC3F4e4E4ZU/RtaiLk2q4mjjRpSs2pdIyn/hTLsQytKOw6vupOrQolEdTvikbuzTGF+M+bu+Cc5LRkacKbGw/BlJFmUP0C90iVUfsKnMV/OQV+jKrfhp4cgVLlI5ukDKC3ieQRxs/dqAGwdIh/GxK8f8XprZCIZnJ9zfbfISELyoDjmUZAx8hISd/Fy09+qo9dPvMip7xXBdBHbjk0uWHEg/J6RE5e6AmBxDZ5VxcPdwKoUQx3AmtoJtvyatvoLEQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DB9PR03MB7179.eurprd03.prod.outlook.com (2603:10a6:10:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 15:28:39 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 15:28:39 +0000
Message-ID: <2fb99be0-3dd4-3bee-caa9-774ce8e2cd4b@seco.com>
Date:   Mon, 13 Mar 2023 11:28:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] rtc: abx80x: Don't warn about oscillator failure after
 PoR
Content-Language: en-US
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221222215858.1886378-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20221222215858.1886378-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0031.namprd20.prod.outlook.com
 (2603:10b6:208:e8::44) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DB9PR03MB7179:EE_|DB8EUR05FT055:EE_|PR3PR03MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: e64a9121-7346-43c0-5efe-08db23d7a48e
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hlr7Gnigz65lpCo5bBm+V5gr6M4yocdTPo51dO/KbtMY7vXQzfHYIB0oSMFtBxjNgo4kqTpjzk0hnwxavdyj8V9tWxiTBJwQCj4/ShstW2q/fqbMvxUzb4XvzhqrTCJ8ZxfFySOncTHWLeASYDypYG9rZFZpddF/PaORQ/kZh5y7KmhFczkZueaRuL5FHrB4o4FM5scUdFna6q4mhu9K7GxWcCqBCMLKUZ05QGc9pKgZ+Q/pYyzhuVTgfoJAemMKvvrmZEVgZ/3+H5NsS1+7KWDpbW5GMxJWnz8zbtIdUjJ1DVMmoJXERkMnK3Kjq+XFqlvGGNYbDdJzuSCJH1uQkzVUMGPXX4k/w/1IEYEs+F4lcqXjXla5kNmft7NgRwSdQ69TxoU5aRRv9ezPzKAHGmk8jIK6jr0rm5r7qx9SgP9l5rJuMgp6WW2UJdX2NnsfgvX1etrPhJJbk1Cx/ru09M1AWydLePyfDYYKw5ZLq/8hej+N5cN4qtjU4nJLTmwCD/8uq9wDU9Ng+zTLv2FtR4EM0zln9fKuP7LsDtbMzSLSXW8XhJsFN55RTDoMdjka64Immu2licy4rfSrh6EdArLLu6GLUayAdEEr7WDqQb4hKhm5zgsWqR8IswFCKTtYYi71ZFIMAqWNH7LnZxsPWCFzO+Pk3DtqnGCrWbrPJrPuwQDiwvDWAIErDjbE4hFNP+hvuvTa8HQ8I+1RrbI5iRL2ZzJHnJqIknpTYYHl2QaGiyvTDeBEx7UsRvoZrQp4b/OOGI/hAyEjxpXZwz8pNQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39850400004)(366004)(346002)(451199018)(86362001)(36756003)(31696002)(38100700002)(38350700002)(44832011)(5660300002)(52116002)(6486002)(110136005)(8936002)(316002)(66946007)(478600001)(41300700001)(4326008)(83380400001)(8676002)(66556008)(66476007)(6506007)(6512007)(6666004)(53546011)(26005)(186003)(2616005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7179
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT055.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9a3acde0-2d11-4cbf-6103-08db23d79f09
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HIeE+KvbCVyDVr/q/sbtg37UZAuAFNlRf5KRZso/xQJuTPXRvXjx3TUfZEjyg5j8UeoDCjvJDwbu2gUQlzzDjRb5MRyUjKQjQFe5XxSSArhxyA0YRzwOT8cdrbyq0RB2l9nz9Q5cRGf6bwRHzHt52f/TvPsbz3Xs0O/5ZdT+IJBfx8PnUudxLpxw0szZm5QMFT6IwktQgnFw7grljrHm4RJfRDFQO2uSEL9Di/wUlAB+5anQu7xFgPnQBGL9z7spaGZzsJNj+TThHwTvx/Pf5D/7YM9AQTJ2JUPXkolaKZpLzfkbM1DDOZZ28cynec1s6JNRG0f3IUauIXzvJEqj7pl/tx0Hpt7y6wVpgV7r457ZONwUTGgbeDjyi+clPUGW9AKHm7MjWiNNZGQvFTvm79Fp/c1sDd+6MofG6BV90uTi6NL9Sb6uG/8V7LQM7HN3L68QPfe6karvwEwQ7y1xT6WCkOl7d3Oq2CsMA8s3do9GX9UdVMEvS5XErvNsekMTiXRcrR118dO+6YSBGide1HOGxQ/VVN6eyKEWob10BjqB+LYfp6ot/TQMuU1jMzzVAxpaZs9IQYw8BtmF5ETFQ6lpI8I3xXRJa5qsAmiyOOfkhkw/CXT3UaIZN+yg0lF4xdeARqPKG3QTYwWGSlawG+px9XwAwlPZnD9SxkKldvMAyy0Xu+v7g+GQIlkShhHnTQCzqZqeSTbauIcY/o6qt5oFDghCUI6Oth/8tMIeu4TKy8fdf4ZiLym6+H/I8GjRKrdDVzck0n18p9xTVGlN2AJzVseBk8atgrgT11/kXkP2pBPSIxW2YI208xanlc6
X-Forefront-Antispam-Report: CIP:20.160.56.86;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39850400004)(396003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(44832011)(5660300002)(40460700003)(83380400001)(478600001)(47076005)(82310400005)(6506007)(26005)(6512007)(6666004)(6486002)(2616005)(336012)(53546011)(186003)(356005)(70206006)(4326008)(70586007)(40480700001)(8936002)(41300700001)(8676002)(31696002)(86362001)(316002)(110136005)(36860700001)(34020700004)(7596003)(7636003)(31686004)(2906002)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 15:28:48.7854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a9121-7346-43c0-5efe-08db23d7a48e
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.86];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT055.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6652
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/22 16:58, Sean Anderson wrote:
> According to the datasheet, the "oscillator failure" bit is set
> 
>> ...on a power on reset, when both the system and battery voltages have
>> dropped below acceptable levels. It is also set if an Oscillator Failure
>> occurs....
> 
> From testing, this bit is also set if a software reset is initiated.
> 
> This bit has a confusing name; it really tells us whether the time data
> is valid. We clear it when writing the time. If it is still set, that
> means there is a persistent issue (such as an oscillator failure),
> instead of a transient one (such as power loss).
> 
> Because there are several other reasons which might cause this bit
> to be set (including booting for the first time or a battery failure),
> do not warn about oscillator failures willy-nilly. This may cause system
> integrators to waste time looking into the wrong line of investigation.
> 
> We continue to warn the user if the oscillator actually fails so they
> can e.g. replace the crystal. Additionally, this can help debug failed
> batteries, since you will see "Time data invalid" when enabling
> debugging.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> Note that the following drivers all warn when they detect a problem with
> the oscillator:
> 
> drivers/rtc/rtc-ds1672.c
> drivers/rtc/rtc-pcf*.c
> drivers/rtc/rtc-rs5c*.c
> drivers/rtc/rtc-sc27xx.c
> 
> So warning about such an error has good precedent.
> 
> Changes in v2:
> - Use debug instead of info in the typical case (no battery)
> 
>  drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 9b0138d07232..a8b0fa5565c7 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -115,6 +115,7 @@ struct abx80x_priv {
>  	struct rtc_device *rtc;
>  	struct i2c_client *client;
>  	struct watchdog_device wdog;
> +	bool wrote_time;
>  };
>  
>  static int abx80x_write_config_key(struct i2c_client *client, u8 key)
> @@ -167,6 +168,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
>  static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>  	unsigned char buf[8];
>  	int err, flags, rc_mode = 0;
>  
> @@ -181,7 +183,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  			return flags;
>  
>  		if (flags & ABX8XX_OSS_OF) {
> -			dev_err(dev, "Oscillator failure, data is invalid.\n");
> +			/*
> +			 * The OF bit can be set either because of a reset
> +			 * (PoR/Software reset) or because of an oscillator
> +			 * failure. Effectively, it indicates that the stored
> +			 * time is invalid. When we write the time, we clear
> +			 * this bit. If it stays set, then this indicates an
> +			 * oscillator failure.
> +			 */
> +			if (priv->wrote_time)
> +				dev_err(dev, "Oscillator failure\n");
> +			else
> +				dev_dbg(dev, "Time data invalid\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -207,6 +220,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>  	unsigned char buf[8];
>  	int err, flags;
>  
> @@ -240,6 +254,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		dev_err(&client->dev, "Unable to write oscillator status register\n");
>  		return err;
>  	}
> +	priv->wrote_time = true;
>  
>  	return 0;
>  }

ping?
